//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableVC: UITableViewController {
    
    private var posts: PostResponse.Response?
    private let vkApi = VKApi()
    private var userPhotoUrl = ""
    private var nextFrom = ""
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        requestFromApi()
        configureRefreshControl()
    }
    
    private func configureTableView() {
        tableView.register(WhatsNewCell.self, forCellReuseIdentifier: WhatsNewCell.reuseId)
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseId)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    private func requestFromApi() {
        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] in
            let user = RealmService.manager.getAllObjects(of: User.self)
            self?.userPhotoUrl = user[0].photo100 ?? ""
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)],
                                       with: .automatic)
        }
        
        self.vkApi.getNewsfeed(nextBatch: nil, startTime: nil) { [weak self] items in
            self?.nextFrom = items.nextFrom ?? ""
            self?.posts = items
            self?.tableView.reloadData()
        }
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Constants.Colors.vkDarkGray
        refreshControl?.attributedTitle = NSMutableAttributedString(string: "Refreshing...", attributes: [.foregroundColor: Constants.Colors.vkDarkGray])
        refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(sender:AnyObject) {
        self.refreshControl?.beginRefreshing()
        
        let freshestNews = Int(self.posts?.items.first?.date ?? Date().timeIntervalSince1970)
        
        vkApi.getNewsfeed(nextBatch: nil, startTime: String(freshestNews + 1)) { [weak self] items in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            print(items.items.count)
            
            guard items.items.count > 0 else {
                return
            }
            self.posts?.addToBeggining(news: items)
            
            let indexPathes = items.items.enumerated().map { offset, _ in
                IndexPath(row: offset, section: 2)
            }
            self.tableView.insertRows(at: indexPathes, with: .automatic)
        }
    }
}


// MARK: - TableView DataSource

extension NewsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return posts?.items.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell else { return UITableViewCell() }
            if let photoUrl = URL(string: userPhotoUrl) {
                whatsNewCell.profilePhoto.kf.setImage(with: photoUrl)
            }
            return whatsNewCell
            
        } else if indexPath.section == 1 {
            guard let storiesCell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell else { return UITableViewCell() }
            return storiesCell
            
        } else {
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else { return UITableViewCell() }
            guard let postItem = posts, !postItem.items.isEmpty else {
                return UITableViewCell()
            }
            
            let post = postItem.items[indexPath.row]
            if post.sourceId > 0 {
                let user = postItem.profiles.first(where: { $0.id == abs(post.sourceId) })
                postCell.postAuthor.text = user?.getFullName()
                postCell.postAuthorImage.kf.setImage(with: URL(string: user?.photo100 ?? ""))
            } else {
                let community = postItem.groups.first(where: { $0.id == abs(post.sourceId) })
                postCell.postAuthor.text = community?.name
                postCell.postAuthorImage.kf.setImage(with: URL(string: community?.photo50 ?? ""))
            }
            
            let date = Date(timeIntervalSince1970: post.date).getElapsedInterval()
            postCell.publishDate.text = "\(date) ago"
            postCell.postText.text = post.text
            
            if let attachments = post.attachments {
                if attachments[0].type.contains("photo") || attachments[0].type.contains("post") {
                    postCell.postImageViewHeightConstraint.constant = 288
                    postCell.layoutIfNeeded()
                    let retry = DelayRetryStrategy(maxRetryCount: 3, retryInterval: .seconds(1))
                    postCell.postImageView.kf.indicatorType = .activity
                    postCell.postImageView.kf.setImage(with: URL(string: attachments[0].photo?.highResPhoto ?? ""),
                                                       options: [.retryStrategy(retry)])
                } else {
                    postCell.postImageView.image = nil
                    postCell.postImageViewHeightConstraint.constant = 0
                    postCell.layoutIfNeeded()
                }
            } else if post.photos != nil {
                if let photoUrl = URL(string: post.photos?[0].highResPhoto ?? "") {
                    postCell.postImageView.kf.indicatorType = .activity
                    postCell.postImageView.kf.setImage(with: photoUrl)
                }
            }
            
            postCell.postStatistics.updateControls(likes: post.likes?.count ?? 0, comments: post.comments.count, reposts: post.reposts.count, views: post.views?.count ?? 0)
            return postCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 64
        } else if indexPath.section == 1 {
            return 112
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.kf.cancelDownloadTask()
    }
}

// MARK: - TableView Prefetching

extension NewsTableVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxRow = indexPaths.map({ $0.row }).max(),
            let previousPostQuntity = posts?.items.count
        else { return }
        
        print("maxRow: ", maxRow)
        
        if maxRow > previousPostQuntity - 5,
            isLoading == false {
            isLoading = true
            
            vkApi.getNewsfeed(nextBatch: nextFrom, startTime: nil) { [weak self] items in
                guard
                    let self = self,
                    items.items.count > 0,
                    let oldIndex = self.posts?.items.count
                else { return }
                
                var indexPathes: [IndexPath] = []
                self.nextFrom = items.nextFrom ?? ""
                self.posts?.addToEnd(news: items)
                for i in oldIndex..<(self.posts?.items.count)! {
                    indexPathes.append(IndexPath(row: i, section: 2))
                }
                print("indexs: ", indexPaths)
                self.tableView.insertRows(at: indexPathes, with: .automatic)
                
                self.isLoading = false
            }
        }
    }
}

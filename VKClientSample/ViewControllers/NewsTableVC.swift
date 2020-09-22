//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

enum SectionTypes: Int, CaseIterable {
    case whatsNew = 0
    case stories = 1
    case post = 2
    
    static func numberOfSections() -> Int {
        return self.allCases.count
    }
    
    static func getSection(_ section: Int) -> SectionTypes {
        return self.allCases[section]
    }
}

class NewsTableVC: UITableViewController {
    
    private var posts: Response?
    private let vkApi = VKApi()
    var photoService: PhotoService?
    private var userPhotoUrl = ""
    private var nextFrom = ""
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService.init(container: tableView)
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
        tableView.backgroundColor = .white
        tableView.alpha = 0.0
    }
    
    private func requestFromApi() {
        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] in
            let user = RealmService.manager.getAllObjects(of: User.self)
            self?.userPhotoUrl = user[0].imageUrl ?? ""
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: SectionTypes.whatsNew.rawValue),
                                            IndexPath(row: 0, section: SectionTypes.stories.rawValue)],
                                       with: .automatic)
        }
        
        self.vkApi.getNewsfeed(nextBatch: nil, startTime: nil) { [weak self] items in
            self?.nextFrom = items.nextFrom ?? ""
            self?.posts = items
            self?.tableView.alpha = 1.0
//            print("❗️❗️❗️ \(items.items)")
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
//            self.posts?.addToBeggining(news: items)
            
            let indexPathes = items.items.enumerated().map { offset, _ in
                IndexPath(row: offset, section: SectionTypes.post.rawValue)
            }
            self.tableView.insertRows(at: indexPathes, with: .automatic)
        }
    }
}


// MARK: - TableView DataSource

extension NewsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SectionTypes.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionTypes.getSection(section) {
        case .whatsNew:
            return 1
        case .stories:
            return 1
        case .post:
            return posts?.items.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionTypes.getSection(indexPath.section) {
        case .whatsNew:
            guard let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell else { return UITableViewCell() }
                whatsNewCell.profilePhoto.image = photoService?.photo(atIndexpath: indexPath, byUrl: userPhotoUrl)
            return whatsNewCell
        case .stories:
            guard let storiesCell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell else { return UITableViewCell() }
            return storiesCell
        case .post:
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else { return UITableViewCell() }
            
            guard let postItem = posts, !postItem.items.isEmpty else {
                return UITableViewCell()
            }
            let post = postItem.items[indexPath.row]
            
            postCell.configure(with: post, author: postItem)
            
            return postCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionTypes.getSection(indexPath.section) {
        case .whatsNew:
            return 64.0
        case .stories:
            return 112.0
        case .post:
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
        
        if maxRow > previousPostQuntity - 5,
            isLoading == false {
            isLoading = true
            
            vkApi.getNewsfeed(nextBatch: nextFrom, startTime: nil) { [weak self] items in
                guard
                    let self = self,
                    items.items.count > 0,
                    let oldIndex = self.posts?.items.count
                else { return }
                print("❗️New Posts❗️ \(items.items)")
                var indexPathes: [IndexPath] = []
                self.nextFrom = items.nextFrom ?? ""
//                self.posts?.addToEnd(news: items)
                for i in oldIndex..<(self.posts?.items.count)! {
                    indexPathes.append(IndexPath(row: i, section: SectionTypes.post.rawValue))
                }
                
                self.tableView.insertRows(at: indexPathes, with: .automatic)
                
                self.isLoading = false
            }
        }
    }
}

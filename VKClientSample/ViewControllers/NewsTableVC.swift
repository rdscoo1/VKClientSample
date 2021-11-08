//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

// MARK: - NewsSections

enum NewsSections {
    case stories
    case whatsNew
    case posts(Response)
}

class NewsTableVC: UITableViewController {
    
    // MARK: - Private Properties
    
    private var posts: Response?
    private let vkApi = NetworkService()
    private var photoService: PhotoService?
    private let activityIndicator = CustomActivityIndicator(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    private var sections: [NewsSections] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private Variables
    
    private var userPhotoUrl = ""
    private var userName = ""
    private var nextFrom = ""
    private var isLoading = false
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = Constants.Colors.theme
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService.init(container: tableView)
        
        configureTableView()
        
        loadFromRealm()
        requestFromApi()
        
        setupRefreshControl()
    }
    
    // MARK: - Private Methods
    
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
        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] users in
            RealmService.manager.saveObjects(users)
            let user = RealmService.manager.getAllObjects(of: User.self).first(where: { $0.id == Int(Session.shared.userId) })
            self?.userPhotoUrl = user?.imageUrl ?? ""
            self?.userName = user?.firstName ?? ""
            self?.sections.append(.stories)
            self?.sections.append(.whatsNew)
        }
        
        self.vkApi.getNewsfeed(nextBatch: nil, startTime: nil) { [weak self] items in
            self?.nextFrom = items.nextFrom ?? ""
            self?.sections.append(.posts(items))
        }
    }
    
    private func loadFromRealm() {
        let user = RealmService.manager.getAllObjects(of: User.self).first(where: { $0.id == Int(UserDefaults.standard.userId ?? "") })
        userPhotoUrl = user?.imageUrl ?? ""
        userName = user?.firstName ?? ""
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0),
                                  IndexPath(row: 0, section: 1)],
                             with: .automatic)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
//        refreshControl?.tintColor = UIColor.clear
        refreshControl?.backgroundColor = Constants.Colors.newsSeparator
        refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl?.addSubview(activityIndicator)
        tableView.refreshControl = refreshControl
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: refreshControl!.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: refreshControl!.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 32),
            activityIndicator.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    // MARK: - Action
    
    @objc private func refresh(sender:AnyObject) {
        self.refreshControl?.beginRefreshing()
        
        let freshestNews = Int(self.posts?.items.first?.date ?? Date().timeIntervalSince1970)

        vkApi.getNewsfeed(nextBatch: nil, startTime: String(freshestNews + 1)) { [weak self] items in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            //            print(items.items.count)

            guard items.items.count > 0 else {
                return
            }
            self.posts?.addToBeggining(news: items)

            let indexPathes = items.items.enumerated().map { offset, _ in
                IndexPath(row: offset, section: 2)
            }
//            self.tableView.insertRows(at: indexPathes, with: .automatic)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if refreshControl?.isHidden == true {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.transform = .identity
        }
        // Distance the table has been pulled >= 0
        let pullDistance = max(0.0, -(self.refreshControl?.frame.origin.y ?? 0))
        
        // Calculate the pull ratio, between 0.0-0.95
        let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0 - 0.05
        
        if !activityIndicator.isAnimating {
            if refreshControl?.isRefreshing == true {
                activityIndicator.setStrokeEnd(value: 0.95)
                activityIndicator.startAnimating()
            } else {
                activityIndicator.setStrokeEnd(value: pullRatio)
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pullDistance = Double(max(0.0, -(self.refreshControl?.frame.origin.y ?? 0)))
        if refreshControl?.isRefreshing == false && activityIndicator.isAnimating == true {
            UIView.animate(withDuration: pullDistance / 1000) {
                self.activityIndicator.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                self.activityIndicator.layoutIfNeeded()
                self.activityIndicator.isHidden = false
            }
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension NewsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .stories:
            return 1
        case .posts(let posts):
            return posts.items.count
        case .whatsNew:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .whatsNew:
            guard let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell else { return UITableViewCell() }
            whatsNewCell.profilePhoto.image = photoService?.photo(atIndexpath: indexPath, byUrl: userPhotoUrl)
            return whatsNewCell
        case .posts(let posts):
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else { return UITableViewCell() }
            guard !posts.items.isEmpty else {
                return UITableViewCell()
            }
            let post = posts.items[indexPath.row]
            
            postCell.configure(with: post, author: posts)
            
            return postCell
        case .stories:
            guard let storiesCell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell else { return UITableViewCell() }
            storiesCell.userPhoto = userPhotoUrl
            storiesCell.userName = userName
            return storiesCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .stories:
            return 112.0
        case .posts(_):
            return UITableView.automaticDimension
        case .whatsNew:
            return 64.0
        }
    }
}

// MARK: - TableView Prefetching
//
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
                //                print("❗️New Posts❗️ \(items.items)")
                var indexPathes: [IndexPath] = []
                self.nextFrom = items.nextFrom ?? ""
                self.posts?.addToEnd(news: items)
                for i in oldIndex..<(self.posts?.items.count)! {
                    indexPathes.append(IndexPath(row: i, section: 2))
                }
                
                self.tableView.insertRows(at: indexPathes, with: .automatic)
                
                self.isLoading = false
            }
        }
    }
}

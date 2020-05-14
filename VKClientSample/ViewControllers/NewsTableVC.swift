//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

enum CellTypes {
    case whatsNewCell
    case storiesCell
    case postCell(item: Post)
}

class NewsTableVC: UITableViewController {
    
    var models: [CellTypes] = []
    var posts = Post.posts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.isAuthorized = true
        
        models.append(.whatsNewCell)
        models.append(.storiesCell)
        models.append(contentsOf: Post.posts.map { CellTypes.postCell(item: $0) })
        
        tableView.register(WhatsNewCell.self, forCellReuseIdentifier: WhatsNewCell.reuseId)
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseId)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        setupActionHideKeyboard()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = models[indexPath.row]
        
        switch cellModel {
        case .whatsNewCell:
            return tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell ?? UITableViewCell()
        case .storiesCell:
            return tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell ?? UITableViewCell()
        case let .postCell(item: post):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else { return UITableViewCell() }
            cell.setPosts(post: post)
            return cell

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = models[indexPath.row]
        switch cellModel {
        case .whatsNewCell:
            return 64
        case .storiesCell:
            return 112
        case .postCell:
            return UITableView.automaticDimension
        }
    }
    
    private func setupActionHideKeyboard() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapOnView)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

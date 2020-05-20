//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class NewsTableVC: UITableViewController {
    
    var posts = PostFactory.posts
    let vkApi = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WhatsNewCell.self, forCellReuseIdentifier: WhatsNewCell.reuseId)
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseId)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        setupActionHideKeyboard()
        
        requestFromApi()
    }
    
    private func requestFromApi() {
        vkApi.getNewsfeed { (post) in
            print(post)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return posts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell else { return UITableViewCell() }
            
            return whatsNewCell
        } else if indexPath.section == 1 {
             guard let storiesCell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as? StoriesCell else { return UITableViewCell() }
            
            return storiesCell
        } else {
             guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else { return UITableViewCell() }
            
            let post = posts[indexPath.row]
            postCell.setPosts(post: post)
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
    
    private func setupActionHideKeyboard() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapOnView)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

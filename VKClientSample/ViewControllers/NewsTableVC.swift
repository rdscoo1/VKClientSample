//
//  NewsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class NewsTableVC: UITableViewController {
    
    var posts = [Post]()
    var communities = [Community]()
    var photos = [String?]()
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
        vkApi.getNewsfeed { [weak self] (post) in
            let items = post.items
            self?.posts = items
            self?.communities = post.groups
            
            items.forEach {
                guard let attachment = $0.attachments?.first else {
                    return
                }
                
                if
                    attachment.type == "photo",
                    let sizes = attachment.photo?.sizes,
                    let photoLink = sizes.first(where: { $0.type == "x" })?.url
                    {
                        self?.photos.append(photoLink)
                    } else {
                        print("post -> ", attachment)
                    }
            }
            self?.tableView.reloadData()
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
            let community = communities[indexPath.row]
//            let photo = photos[indexPath.row]

            print(post.debugDescription)
            postCell.postFooter.updateControls(likes: post.likes?.count ?? 0, comments: post.comments.count, reposts: post.reposts.count, views: post.views?.count ?? 0)
            postCell.setPosts(post: post, community: community, photo: "")
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

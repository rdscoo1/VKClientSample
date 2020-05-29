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
    
    var posts: PostResponse.Response?
    let vkApi = VKApi()
    var userPhotoUrl: String? = ""
    
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
        vkApi.getNewsfeed { [weak self] items in
            self?.posts = items
            self?.tableView.reloadData()
        }
        
        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] in
            let user = RealmService.manager.getAllObjects(of: User.self)
            self?.userPhotoUrl = user[0].photo100
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
            return posts?.items.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let whatsNewCell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.reuseId, for: indexPath) as? WhatsNewCell else { return UITableViewCell() }
            if let photoUrl = URL(string: userPhotoUrl!) {
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
                if let photoUrl = URL(string: user?.photo100 ?? "") {
                    postCell.postAuthorImage.kf.setImage(with: photoUrl)
                }
            } else {
                let community = postItem.groups.first(where: { $0.id == abs(post.sourceId) })
                if let photoUrl = URL(string: community?.photo50 ?? "") {
                    postCell.postAuthorImage.kf.setImage(with: photoUrl)
                }
            }
            
            let date = Date(timeIntervalSince1970: post.date).getElapsedInterval()
            postCell.publishDate.text = "\(date) ago"
            postCell.postText.text = post.text
            
            if !post.attachments.isEmpty {
                if let photoUrl = URL(string: post.attachments[0].photo?.highResPhoto ?? "") {
                    postCell.postImageView.kf.setImage(with: photoUrl)
                }
            } else if post.photos != nil {
                if let photoUrl = URL(string: post.photos?[0].highResPhoto ?? "") {
                    postCell.postImageView.kf.setImage(with: photoUrl)
                }
            }
            
            postCell.postFooter.updateControls(likes: post.likes?.count ?? 0, comments: post.comments.count, reposts: post.reposts.count, views: post.views?.count ?? 0)
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

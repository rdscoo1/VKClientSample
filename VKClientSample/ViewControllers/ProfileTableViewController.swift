//
//  ProfileTableViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 26.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    private let vkApi = VKApi()
    private var profile = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ProfileTVCell.self, forCellReuseIdentifier: ProfileTVCell.reuseId)
        
        requestProfileInfo()
    }
    
    private func requestProfileInfo() {
        profile = RealmService.manager.getAll(User.self)

        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] profileInfo in
            self?.profile = profileInfo
            RealmService.manager.saveObjects(profileInfo)
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.reuseId, for: indexPath) as? ProfileTVCell else {
            return UITableViewCell()
        }
        
        let profileInfo = profile[indexPath.row]
        
        cell.configureWith(name: profileInfo.firstName, surname: profileInfo.lastName, status: profileInfo.status)
        if let imageUrl = URL(string: profileInfo.photo100!) {
            cell.avatarImageView.kf.setImage(with: imageUrl)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.0
    }
    
}

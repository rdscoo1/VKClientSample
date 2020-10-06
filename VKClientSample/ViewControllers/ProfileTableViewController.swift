//
//  ProfileTableViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 26.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let vkApi = VKApi()
    private var profile = [User]()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ProfileTVCell.self, forCellReuseIdentifier: ProfileTVCell.reuseId)
        tableView.tableFooterView = UIView()
        
        requestProfileInfo()
    }
    
    // MARK: - Private Methods
    
    private func requestProfileInfo() {
        vkApi.getUserInfo(userId: Session.shared.userId) { [weak self] users in
            //            RealmService.manager.saveObjects(users)
            self?.loadData()
        }
    }
    
    private func loadData() {
        self.profile = RealmService.manager.getAllObjects(of: User.self)
        self.tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension ProfileTableViewController {
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
        
        cell.configure(user: profileInfo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.0
    }
}

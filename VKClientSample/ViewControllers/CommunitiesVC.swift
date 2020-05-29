//
//  CommunitiesVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommunitiesVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var communities = [Community]()
    private let vkApi = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureTableView()
        loadData()
        requestCommunitiesFromApi()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func requestCommunitiesFromApi() {
        vkApi.getGroups { [weak self] in
            self?.loadData()
        }
    }
    
    private func requestSearchedCommunitiesFromApi(groupName: String) {
        vkApi.getSearchedGroups(groupName: groupName) { [weak self] communities in
            self?.communities = communities
            self?.tableView.reloadData()
        }
    }
    
    private func loadData() {
        self.communities = RealmService.manager.getAllObjects(of: Community.self)
        self.tableView.reloadData()
    }
}

extension CommunitiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.reuseId, for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let community = communities[indexPath.row]
        cell.configure(with: community)
        
        return cell
    }
}

extension CommunitiesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            requestSearchedCommunitiesFromApi(groupName: searchText)
        } else {
            loadData()
        }
    }
}

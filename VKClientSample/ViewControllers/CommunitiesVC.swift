//
//  CommunitiesVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 14.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import RealmSwift

class CommunitiesVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private var communities: [Community] = []
    private let vkApi = NetworkService()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = Constants.Colors.theme
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureTableView()
        
        loadData()
        vkApi.getGroups { [weak self] in
            self?.loadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadData() {
        communities = RealmService.manager.getAllObjects(of: Community.self)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CommunitiesVC: UITableViewDataSource {
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

extension CommunitiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommunityVC()
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            vc.community = communities[selectedIndex.row]
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension CommunitiesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            vkApi.getSearchedGroups(groupName: searchText) { [weak self] groups in
                self?.communities = groups
                self?.tableView.reloadData()
            }
        } else {
            vkApi.getGroups { [weak self] in
                self?.loadData()
            }
        }
    }
}

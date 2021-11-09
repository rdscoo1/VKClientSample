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
    
    private var notificationToken: NotificationToken?
    private var communities: Results<Community>?
    private let networkService = NetworkService()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = Constants.Colors.theme
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Constants.Colors.theme
        
        searchBar.barTintColor = Constants.Colors.theme
        searchBar.delegate = self
        configureTableView()
        configureNotificationToken()
        
        networkService.getGroups()
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureNotificationToken() {
        guard let realm = try? Realm() else { return }
        communities = realm.objects(Community.self)
        notificationToken = communities?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self?.tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CommunitiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.reuseId, for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let community = communities![indexPath.row]
        cell.configure(with: community)
        
        return cell
    }
}

extension CommunitiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommunityVC()
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            vc.community = communities![selectedIndex.row]
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
            networkService.getSearchedGroups(groupName: searchText)
        } else {
            networkService.getGroups()
        }
    }
}

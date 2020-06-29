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
    
    var notificationToken: NotificationToken?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var communities: Results<Community>?
    private let vkApi = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureTableView()
        
        vkApi.getGroups()
        handleRealmNotification()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func handleRealmNotification() {
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

extension CommunitiesVC: UITableViewDelegate, UITableViewDataSource {
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

extension CommunitiesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            vkApi.getSearchedGroups(groupName: searchText)
        } else {
            vkApi.getGroups()
        }
    }
}

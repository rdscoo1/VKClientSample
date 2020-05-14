//
//  AddCommunitiyTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class AddCommunitiyTableVC: UITableViewController {
    
    private var searchBar = UISearchBar()
    var communities = [VKCommunityProtocol]()
    let vkApi = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        let searchBarView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(UIScreen.main.bounds.size.width), height: CGFloat(45)))
        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: 44)
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search communities"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBarView.addSubview(searchBar)
        tableView.tableHeaderView = searchBarView;
    }
    
    private func requestFromApi(groupName: String) {
        vkApi.getSearchedGroups(groupName: groupName) { [weak self] groups in
            DispatchQueue.main.async {
                self?.communities = groups
                self?.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.reuseId, for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let community = communities[indexPath.row]
        cell.communityTitle.text = community.name
        cell.communityDescription.text = community.activity
        if let imageUrl = URL(string: community.photo50) {
            cell.communityPhoto.kf.setImage(with: imageUrl)
        }
        
        return cell
    }
}

extension AddCommunitiyTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            requestFromApi(groupName: searchText)
            print("searchText \(searchText)")
    }
}


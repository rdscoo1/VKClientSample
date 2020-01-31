//
//  AddCommunitiyTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class AddCommunitiyTableVC: UITableViewController {
    
    var communities: [Community] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
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
        cell.setCommunities(community: community)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addedCommunity = communities[indexPath.row]
        let communityVC = navigationController?.children.first { $0 is CommunitiesTableVC } as? CommunitiesTableVC
        communityVC?.communities.append(addedCommunity)
        communityVC?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
    
}

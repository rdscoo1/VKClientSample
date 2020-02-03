//
//  FriendsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendsTableVC: UITableViewController {
    
    var friends = Friend.friends
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
    }
    
    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var letter = [String]()
//        let friend = friends[indexPath.row]
//        for key in keys {
//            letter.append("\(key.characters.first!)")
//         }
//         return letter
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        let friend = friends[indexPath.row]
        cell.setFriends(friend: friend)
        
        return cell
    } 
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier,
            segueId == "friendInDetailSeque",
            let friendInDetail = segue.destination as? FriendCollectionVC,
            let selectedIndex = tableView.indexPathForSelectedRow {
                friendInDetail.friend = friends[selectedIndex.row]
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
}

//
//  FriendsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendsTableVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var friends = Friend.friends
    var searchedFriends: [[Friend]] = [[]]
    var sections: [[Friend]] = [[]]
    var uniqueFirstLetters: [String] = Array(Set(Friend.friends.map { $0.titleFirstLetter })).sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        searchBar.delegate = self
        self.tableView.allowsMultipleSelection = true

        
        handleFriends(friend: Friend.friends)
//        setupActionHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    func handleFriends(friend: [Friend]) {
        uniqueFirstLetters = Array(Set(friend.map { $0.titleFirstLetter })).sorted()
        sections = uniqueFirstLetters.map { firstLetter in
            return friend
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.surname < $1.surname }
        }
        searchedFriends = sections
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return uniqueFirstLetters[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchedFriends.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return uniqueFirstLetters
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedFriends[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        let friend = searchedFriends[indexPath.section][indexPath.row]
        cell.setFriends(friend: friend)
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier,
            segueId == "friendPhotosSegue",
            let friendPhotos = segue.destination as? FriendCollectionVC,
            let selectedIndex = tableView.indexPathForSelectedRow {
            friendPhotos.friendPhotos = searchedFriends[selectedIndex.section][selectedIndex.row].photos
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    private func setupActionHideKeyboard() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapOnView)
    }
    
    @objc
    private func hideKeyboard() {
        tableView?.endEditing(true)
    }
}

extension FriendsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            friends = sections.flatMap({ $0 }).filter({
                friend -> Bool in
                friend.surname.lowercased().contains(searchText.lowercased())
            })
            handleFriends(friend: friends)
        } else {
            handleFriends(friend: Friend.friends)
        }
        tableView.reloadData()
    }
}

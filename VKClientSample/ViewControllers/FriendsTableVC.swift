//
//  FriendsTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import SnapKit

class FriendsTableVC: UITableViewController {
    
    let vkApi = VKApi()
    @IBOutlet weak var searchBar: UISearchBar!
    private var activityIndicator = UIActivityIndicatorView()
    
    var items = [VKFriendProtocol]()
    var friendsInSection = [Section<VKFriendProtocol>]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        searchBar.delegate = self
        
        configureActivityIndicator()
        requestFromApi()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-48)
            $0.height.width.equalTo(64)
        }
    }
    
    func handleFriends(items: [VKFriendProtocol]) -> [Section<VKFriendProtocol>] {
        return Dictionary(grouping: items) { $0.lastName.prefix(1) }
            .map { Section<VKFriendProtocol>(title: "\($0.key)", items: $0.value) }
            .sorted(by: { $0.title < $1.title })
    }
    
    private func requestFromApi() {
        vkApi.getFriends { [weak self] friends in
                self?.items = friends
                self?.friendsInSection = self!.handleFriends(items: friends)
                self?.tableView.reloadData()
        }
        
        self.activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 1.0
        })
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        requestFromApi()
        
        sender.endRefreshing()
    }
    
    
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier,
            segueId == "friendPhotosSegue",
            let friendPhotos = segue.destination as? FriendCollectionVC,
            let selectedIndex = tableView.indexPathForSelectedRow {
            friendPhotos.friendId = friendsInSection[selectedIndex.section].items[selectedIndex.row].id
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = Constants.Colors.vkBlue
    }
}

extension FriendsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsInSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsInSection[section].title
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsInSection.map { $0.title }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsInSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        let friend = friendsInSection[indexPath.section].items[indexPath.row]
        cell.configure(with: friend)
        
        return cell
    }
}

extension FriendsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            friendsInSection = handleFriends(items: items.filter{
                $0.lastName.lowercased().contains(searchText.lowercased())
            })
        } else {
            friendsInSection = handleFriends(items: items)
        }
        tableView.reloadData()
    }
}

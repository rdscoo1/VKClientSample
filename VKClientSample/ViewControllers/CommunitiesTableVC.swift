//
//  CommunitiesTableVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 17.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CommunitiesTableVC: UITableViewController {
    
    var communities: [Section<VKCommunityProtocol>] = []
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.alpha = 0.0
        
        configureActivityIndicator()

        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return communities.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities[section].items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.reuseId, for: indexPath) as? CommunityCell else {
            return UITableViewCell()
        }
        let community = communities[indexPath.section].items[indexPath.row]
        cell.communityTitle.text = community.name
        cell.communityDescription.text = community.activity
        if let imageUrl = URL(string: community.photo200) {
            cell.communityPhoto.kf.setImage(with: imageUrl)
        }
        
        return cell
    }    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            communities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if
        //            segue.identifier == "addCommunity",
        //            let addCommunityVC = segue.destination as? AddCommunitiyTableVC
        //        {
        //            let availableCommunities = Set(Community.communities).subtracting(communities)
        //            addCommunityVC.communities = Array(availableCommunities)
        //        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
       requestFromApi { [weak self] items in
            //            print("👥 groups: ", items)
            self?.communities.append(Section(title: "Communities", items: items))
            self?.tableView.reloadData()
        }
        
        sender.endRefreshing()
    }
    
    
    private func loadData() {
        requestFromApi { [weak self] items in
            //            print("👥 groups: ", items)
            self?.communities.append(Section(title: "Communities", items: items))
            self?.tableView.reloadData()
        }
        self.activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 1.0
        })
        
    }
    
    private func requestFromApi(completion: @escaping ([VKCommunity]) -> Void) {
        let token = Session.shared.token
        let userId = Session.shared.userId
        let vkApi = VKApi(token: token, userId: userId)
        
        vkApi.getGroups { response in
            switch response {
            case let .success(models):
                if let items = models.response?.items {
                    
                    completion(items)
                } else if
                    let errorCode = models.error?.error_code,
                    let errorMsg = models.error?.error_msg
                {
                    print("❌ #\(errorCode) \(errorMsg)")
                }
            case let .failure(error):
                print("❌ \(error)")
            }
        }
    }
}

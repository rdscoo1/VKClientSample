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
    
    let vkApi = VKApi()
    var communities = [VKCommunityProtocol]()
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        
        tableView.register(UINib(nibName: CommunityCell.reuseId, bundle: nil), forCellReuseIdentifier: CommunityCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        tableView.alpha = 0.0
        
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
    
    private func requestFromApi() {
        vkApi.getGroups { [weak self] groups in
            DispatchQueue.main.async {
                self?.communities = groups
                self?.tableView.reloadData()
            }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = Constants.Colors.vkBlue
    }
}

extension CommunitiesTableVC {
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            communities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

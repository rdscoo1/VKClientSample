//
//  CommunityVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

enum CommunityWallSections: Int, CaseIterable {
    case communityInfo = 0
    case post = 1
    
    static func numberOfSections() -> Int {
        return self.allCases.count
    }
    
    static func getSection(_ section: Int) -> CommunityWallSections {
        return self.allCases[section]
    }
}

class CommunityVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = StretchyTableViewHeader()
    
    private let vkApi = VKApi()
    private var posts: Response?
    
    // MARK: - Public Variables
    
    var communitity: Community!
    
    // MARK: - LifeCycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = nil
        
        if communitity.cover?.enabled == 1 {
            navigationController?.navigationBar.isTranslucent = true
        } else {
            navigationController?.navigationBar.isTranslucent = false
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.tintColor = .white
            } else {
                navigationController?.navigationBar.tintColor = Constants.Colors.vkBlue
            }
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Constants.Colors.theme
        
        configureTableView()
        requestFromApi() 
    }
    
    // MARK: - Private Methods
    
    private func requestFromApi() {
        vkApi.getWall(ownerId: communitity.id) { [weak self] items in
            self?.posts = items
            self?.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
        tableView.register(CommunityInfoCell.self, forCellReuseIdentifier: CommunityInfoCell.reuseId)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0.0
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource

extension CommunityVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CommunityWallSections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch CommunityWallSections.getSection(section) {
        case .communityInfo:
            return 1
        case .post:
            return posts?.items.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CommunityWallSections.getSection(indexPath.section) {
        case .communityInfo:
            guard let communityInfoCell = tableView.dequeueReusableCell(withIdentifier: CommunityInfoCell.reuseId, for: indexPath) as? CommunityInfoCell else {
                return UITableViewCell()
            }
            
            communityInfoCell.configure(with: communitity)
            communityInfoCell.delegate = self
            //            communityInfoCell.configureFollowButton(with: communitity)
            
            return communityInfoCell
        case .post:
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            
            guard let postItem = posts, !postItem.items.isEmpty else {
                return UITableViewCell()
            }
            
            let post = postItem.items[indexPath.row]
            postCell.configure(with: post, author: postItem)
            
            return postCell
        }
    }
}

// MARK: - UITableViewDelegate

extension CommunityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch CommunityWallSections.getSection(indexPath.section) {
        case .communityInfo:
            return 250.0
        case .post:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if CommunityWallSections.communityInfo.rawValue == section {
            headerView.frame = view.bounds
            headerView.setImage(url: communitity.cover?.imageUrl)
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch CommunityWallSections.getSection(section) {
        case .communityInfo:
            if communitity.cover?.enabled == 1 {
                return 144.0
            } else {
                return 0.0
            }
        case .post:
            return 0.0
        }
    }
}

// MARK: - UIScrollViewDelegate

extension CommunityVC: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        if communitity.cover?.enabled == 1 {
            scrollView.contentInsetAdjustmentBehavior = .never
            
            let offset = scrollView.contentOffset.y
            if offset > 80 {
                navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                navigationController?.navigationBar.shadowImage = nil
                if traitCollection.userInterfaceStyle == .light {
                    navigationController?.navigationBar.tintColor = Constants.Colors.vkBlue
                }
            } else {
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.tintColor = .white
            }
        } else {
            scrollView.contentInsetAdjustmentBehavior = .automatic
            
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            if traitCollection.userInterfaceStyle == .light {
                navigationController?.navigationBar.tintColor = Constants.Colors.vkBlue
            } else {
                navigationController?.navigationBar.backgroundColor = Constants.Colors.theme
                navigationController?.navigationBar.tintColor = .white
            }
        }
    }
}

// MARK: - CommunityInfoCellDelegate

extension CommunityVC: CommunityInfoCellDelegate {
    func changeFollowState() {
        print("hello")
        presentAlertOnMainTread(message: "Вы подписались на сообщество")
    }
}

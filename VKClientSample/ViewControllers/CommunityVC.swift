//
//  CommunityVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

// MARK: - CommunitySections

enum CommunityInfoSection: Equatable {
    case coverInfo
    case communityActions(followButtonState: FollowState)
    case communityInfo
}

enum CommunitySections {
    case communityInfo([CommunityInfoSection])
    case wall(Response)
}

class CommunityVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = StretchyTableViewHeader()
    private let vkApi = NetworkService()
    
    // MARK: - Private Variables
    
    private var posts: Response?
    private var sections: [CommunitySections] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Public Variables
    
    var community = Community()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = nil
        
        if community.cover?.enabled == 1 {
            navigationController?.navigationBar.isTranslucent = true
        } else {
            navigationController?.navigationBar.isTranslucent = false
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.tintColor = .white
            } else {
                navigationController?.navigationBar.tintColor = Constants.Colors.vkBlue
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if community.isMember == 0 {
            RealmService.manager.removeCommunity(groupId: community.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        sections.append(.communityInfo([.coverInfo]))
        sections.append(.communityInfo([.communityActions(followButtonState: community.followState)]))
        sections.append(.communityInfo([.communityInfo]))
        
        requestFromApi()
    }
    
    // MARK: - Private Methods
    
    private func requestFromApi() {
        vkApi.getWall(ownerId: community.id) { [weak self] items in
            self?.sections.append(.wall(items))
        }
    }
    
    private func configureTableView() {
        tableView.backgroundColor = Constants.Colors.theme
        
        view.addSubview(tableView)
        
        tableView.register(CommunityCoverInfoCell.self, forCellReuseIdentifier: CommunityCoverInfoCell.reuseId)
        tableView.register(CommunityActionsCell.self, forCellReuseIdentifier: CommunityActionsCell.reuseId)
        tableView.register(CommunityInfoCell.self, forCellReuseIdentifier: CommunityInfoCell.reuseId)
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .communityInfo(let cells):
            return cells.count
        case .wall(let posts):
            return posts.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .communityInfo(let cells):
            switch cells[indexPath.row] {
            case .coverInfo:
                guard let communityCoverInfoCell = tableView.dequeueReusableCell(withIdentifier: CommunityCoverInfoCell.reuseId, for: indexPath) as? CommunityCoverInfoCell else {
                    return UITableViewCell()
                }
                
                communityCoverInfoCell.configure(with: community)
                
                return communityCoverInfoCell
            case .communityActions(let followButtonState):
                guard let communityActionsCell = tableView.dequeueReusableCell(withIdentifier: CommunityActionsCell.reuseId, for: indexPath) as? CommunityActionsCell else {
                    return UITableViewCell()
                }
                
                communityActionsCell.delegate = self
                communityActionsCell.configure(with: followButtonState)
                
                return communityActionsCell
            case .communityInfo:
                guard let communityInfoCell = tableView.dequeueReusableCell(withIdentifier: CommunityInfoCell.reuseId, for: indexPath) as? CommunityInfoCell else {
                    return UITableViewCell()
                }
                
                communityInfoCell.configure(with: community.membersQuantity)
                
                return communityInfoCell
            }
        case .wall(let posts):
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            
            guard !posts.items.isEmpty else {
                return UITableViewCell()
            }
            
            let post = posts.items[indexPath.row]
            postCell.configure(with: post, author: posts)
            
            return postCell
        }
    }
}

// MARK: - UITableViewDelegate

extension CommunityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .communityInfo(let cells):
            switch cells[indexPath.row] {
            case .coverInfo:
                return 112.0
            case .communityActions(_):
                return 96.0
            case .communityInfo:
                return 48.0
            }
        case .wall(_):
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .communityInfo(let cells):
            for cell in cells {
                if cell == .coverInfo {
                    headerView.frame = view.bounds
                    headerView.setImage(url: community.cover?.imageUrl)
                    return headerView
                } else {
                    return nil
                }
            }
            return nil
        case .wall(_):
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .communityInfo(let cells):
            for cell in cells {
                if cell == .coverInfo {
                    guard community.cover?.enabled == 1 else {
                        return 0.0
                    }
                    return 144.0
                } else {
                    return 0.0
                }
            }
            return 0.0
        case .wall(_):
            return 0.0
        }
    }
}

// MARK: - UIScrollViewDelegate

extension CommunityVC: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        if community.cover?.enabled == 1 {
            scrollView.contentInsetAdjustmentBehavior = .never
            
            let offset = scrollView.contentOffset.y
            if offset > 60 {
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
        if community.followState == .following {
            present(getFollowActionSheet(unfollowHandler: { [weak self] _ in
                guard let self = self else { return }
                
                self.vkApi.leaveGroup(groupId: self.community.id) { [weak self] response in
                    guard let self = self else { return }
                    guard response.response == 1 else {
                        print("Запрос отклонен")
                        return
                    }
                    print("Left \(String(describing: self.community.debugDescription))")
                    
                    RealmService.manager.editCommunityMembership(groupId: self.community.id, isMember: 0)
                    //                    self.community.isMember = 0
                    self.sections[1] = .communityInfo([.communityActions(followButtonState: self.community.followState)])
                    self.tableView.reloadData()
                    let stoppedFollowingPhrase = NSLocalizedString("You have unfollowed the community", comment: "")
                    self.presentAlertOnMainTread(message: stoppedFollowingPhrase)
                }
            }),
            animated: true)
        } else {
            self.vkApi.joinGroup(groupId: self.community.id) { [weak self] response in
                guard let self = self else { return }
                guard response.response == 1 else {
                    print("Запрос отклонен")
                    return
                }
                
                print("Started following \(String(describing: self.community.debugDescription))")
                
                if RealmService.manager.communityExist(id: self.community.id) {
                    RealmService.manager.editCommunityMembership(groupId: self.community.id, isMember: 1)
                } else {
                    self.community.isMember = 1
                    RealmService.manager.saveObject(self.community)
                }
                self.sections[1] = .communityInfo([.communityActions(followButtonState: self.community.followState)])
                //                RealmService.manager.saveObject(self.communitity)
                self.tableView.reloadData()
                let startedFollowingPhrase = NSLocalizedString("You are now following this community", comment: "")
                self.presentAlertOnMainTread(message: startedFollowingPhrase)
            }
        }
    }
}

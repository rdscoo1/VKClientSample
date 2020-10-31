//
//  CommunityVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

// MARK: - CommunityWallSections

enum CommunityWallSections {
    case communityInfo(followButtonState: FollowButtonState)
    case post(Response)
}

class CommunityVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = StretchyTableViewHeader()
    private let vkApi = VKApi()
    
    // MARK: - Private Variables
    
    private var posts: Response?
    private var sections: [CommunityWallSections] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Public Variables
    
    var communitity: Community!
    
    // MARK: - LifeCycle
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Constants.Colors.theme
        
        configureTableView()
        
        sections.append(.communityInfo(followButtonState: communitity.followState))
        requestFromApi() 
    }
    
    // MARK: - Private Methods
    
    private func requestFromApi() {
        vkApi.getWall(ownerId: communitity.id) { [weak self] items in
            self?.sections.append(.post(items))
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .communityInfo(followButtonState: _):
            return 1
        case .post(let items):
            return items.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .communityInfo(followButtonState: _):
            guard let communityInfoCell = tableView.dequeueReusableCell(withIdentifier: CommunityInfoCell.reuseId, for: indexPath) as? CommunityInfoCell else {
                return UITableViewCell()
            }
            
            communityInfoCell.community = communitity
            
            communityInfoCell.configure(with: communitity)
            communityInfoCell.delegate = self
            
            return communityInfoCell
        case .post(let posts):
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
        case .communityInfo(followButtonState: _):
            return 250.0
        case .post(_):
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView.frame = view.bounds
            headerView.setImage(url: communitity.cover?.imageUrl)
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .communityInfo(followButtonState: _):
            if communitity.cover?.enabled == 1 {
                return 144.0
            } else {
                return 0.0
            }
        case .post(_):
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
        if communitity.isMember == 1 {
            present(getFollowActionSheet(unfollowHandler: { [weak self] _ in
                guard let self = self else { return }
                
                self.vkApi.leaveGroup(groupId: self.communitity.id) { [weak self] response in
                    guard response.response == 1 else {
                        print("Запрос отклонен")
                        return
                    }
                    self?.communitity.isMember = 0
                    print("Left \(String(describing: self?.communitity))")
                    //                        RealmService.manager.removeCommunity(groupId: self!.communitity.id)
                    let stoppedFollowingPhrase = NSLocalizedString("You have unfollowed the community", comment: "")
                    self?.presentAlertOnMainTread(message: stoppedFollowingPhrase)
                }
            }),
            animated: true)
        } else {
            self.vkApi.joinGroup(groupId: self.communitity.id) { [weak self] response in
                guard response.response == 1 else {
                    print("Запрос отклонен")
                    return
                }
                self?.communitity.isMember = 1
                print("Following \(String(describing: self?.communitity))")
                //                    RealmService.manager.saveObject(self!.communitity)
                let startedFollowingPhrase = NSLocalizedString("You are now following this community", comment: "")
                self?.presentAlertOnMainTread(message: startedFollowingPhrase)
            }
        }
    }
}

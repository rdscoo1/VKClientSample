//
//  FriendsListProtocols.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 09.11.2021.
//  Copyright © 2021 Roman Khodukin. All rights reserved.
//

import Foundation

// MARK: - Interactor

protocol FriendListInteractorInput: AnyObject {
    func loadFriends()
}

protocol FriendListInteractorOutput: AnyObject {
    func didReceiveFriends()
}

// MARK: - Presenter

protocol FriendsListPresenterInput: AnyObject {
    func viewDidLoad()
    func didPullToRefresh()
}

protocol FriendsListPresenterOutput: AnyObject {
    func fetchFriends()
}

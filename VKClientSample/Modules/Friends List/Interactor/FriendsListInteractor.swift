//
//  FriendsListInteractor.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 09.11.2021.
//  Copyright © 2021 Roman Khodukin. All rights reserved.
//

import Foundation

class FriendsListInteractor {

    // MARK: - Private properties
    private let databaseManager: DatabaseManagerProtocol

    // MARK: - Public properties

    weak var output: FriendListInteractorOutput?

    // MARK: - Init

    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
}

// MARK: - FriendListInteractorInput

extension FriendsListInteractor: FriendListInteractorInput {
    func loadFriends() {
        //
    }
}

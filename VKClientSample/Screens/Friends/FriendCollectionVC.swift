//
//  FriendCollectionVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FriendInDetails"

class FriendCollectionVC: UICollectionViewController {

    var friend: Friend?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = friend?.name
    }
   

// MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FriendCVCell,
            let myFriend = friend
            else {
                return UICollectionViewCell()
        }
        cell.friendPhoto.image = UIImage(imageLiteralResourceName: myFriend.avatar)
    
        return cell
    }
}

//
//  FriendCVCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCVCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
    static let reuseId = "FriendPhotos"
    
//    func setFriends(friend: Friend.friends) {
//        friendFullName.text = "\(friend.name) \(friend.surname)"
//        friendPhoto.image = UIImage(imageLiteralResourceName: friend.avatar)
//    }
}

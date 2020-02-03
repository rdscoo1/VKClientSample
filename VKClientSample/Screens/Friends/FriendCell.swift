//
//  FriendsCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var friendFullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendPhoto.layer.cornerRadius = 24
        friendPhoto.layer.masksToBounds = true
    }
    
    func setFriends(friend: Friend) {
        friendFullName.text = "\(friend.name) \(friend.surname)"
        friendPhoto.image = UIImage(imageLiteralResourceName: friend.avatar)
    }
}

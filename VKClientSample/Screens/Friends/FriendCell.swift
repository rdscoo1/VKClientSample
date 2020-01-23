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
    @IBOutlet weak var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendPhoto.layer.cornerRadius = 24
        friendPhoto.layer.masksToBounds = true
    }
    
    func setFriends(friend: Friend) {
        friendName.text = friend.name
        friendPhoto.image = UIImage(imageLiteralResourceName: friend.avatar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

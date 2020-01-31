//
//  CommunityTableViewCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {

    
    @IBOutlet weak var communityPhoto: UIImageView!
    @IBOutlet weak var communityTitle: UILabel!
    @IBOutlet weak var communityDescription: UILabel!
    
    static let reuseId = "CommunityCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        communityPhoto.layer.cornerRadius = 24
        communityPhoto.layer.masksToBounds = true
    }
    
    func setCommunities(community: Community) {
        communityTitle.text = community.title
        communityDescription.text = community.description
        communityPhoto.image = UIImage(imageLiteralResourceName: community.communityCover)
    }    
}

//
//  CommunityTableViewCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 18.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Kingfisher

class CommunityCell: UITableViewCell {
    
    @IBOutlet weak var communityPhoto: UIImageView!
    @IBOutlet weak var communityTitle: UILabel!
    @IBOutlet weak var communityDescription: UILabel!
    
    static let reuseId = "CommunityCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CommunityCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        communityPhoto.layer.cornerRadius = 24
        communityPhoto.layer.masksToBounds = true
    }
    
    func configure(with community: Community) {
        communityTitle.text = community.name
        communityDescription.text = community.activity
        if let imageUrl = URL(string: community.photo50) {
            communityPhoto.kf.setImage(with: imageUrl)
        }
    }
}

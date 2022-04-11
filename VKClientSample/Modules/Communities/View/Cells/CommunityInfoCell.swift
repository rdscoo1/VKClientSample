//
//  CommunityInfo.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/31/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CommunityInfoCell: UITableViewCell {
    
    static let reuseId = String(describing: CommunityInfoCell.self)
    
    // MARK: - Private Properties
    
    private lazy var memberQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Colors.vkGray
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(memberQuantity)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with members: Int) {
        if members % 10 == 1 {
            memberQuantity.text = "\(members) подписчик"
        } else if members % 10 > 4 {
            memberQuantity.text = "\(members) подписчиков"
        } else {
            memberQuantity.text = "\(members) подписчика"
        }
    }
    
    // MARK: - Private Methods
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            memberQuantity.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            memberQuantity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            memberQuantity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

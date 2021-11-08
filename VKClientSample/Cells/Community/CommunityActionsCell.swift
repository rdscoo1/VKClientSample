//
//  CommunityActionsCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/8/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

protocol CommunityInfoCellDelegate: AnyObject {
    func changeFollowState()
}

class CommunityActionsCell: UITableViewCell {
    
    static let reuseId = "CommunityInfoCell"
    
    // MARK: - Private Properties
    
    private let followButton = FollowButton()
    private lazy var bottomBorder: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        self.contentView.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    // MARK: - Delegate
    
    weak var delegate: CommunityInfoCellDelegate?
    
    // MARK: - Initializers
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder.frame = CGRect(x: 16, y: contentView.frame.height, width: contentView.frame.width - 32, height: 0.5)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with buttonState: FollowState) {
        followButton.setFollow(state: buttonState)
    }
    
    // MARK: - Private Methods
    
    @objc private func changeState() {
        delegate?.changeFollowState()
    }
    
    private func setupUI() {
        backgroundColor = Constants.Colors.theme
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(changeState), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        followButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            followButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 144),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -144),
            followButton.heightAnchor.constraint(equalToConstant: 96),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

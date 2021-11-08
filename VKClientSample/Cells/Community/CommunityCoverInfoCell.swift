//
//  CommunityCoverInfoCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/31/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import Nuke

class CommunityCoverInfoCell: UITableViewCell {
    
    static let reuseId = "CommunityCoverInfoCell"
    
    // MARK: - Private Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Community"
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Colors.vkGray
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var bottomBorder: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        self.contentView.layer.insertSublayer(layer, at: 0)
        return layer
    }()
        
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
    
    func configure(with community: Community) {
        nameLabel.text = community.name
        
        if community.status == "" {
            statusLabel.text = community.activity
        } else {
            statusLabel.text = community.status
        }
        
        if let imageUrl = URL(string: community.imageUrl ?? "") {
            Nuke.loadImage(with: imageUrl, into: photoImageView)
        }
        
        layer.frame = CGRect(x: 0.0, y: 111.0, width: bounds.width, height: 1.0)
        contentView.layer.addSublayer(bottomBorder)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = Constants.Colors.theme
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(photoImageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: photoImageView.leadingAnchor, constant: -8),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

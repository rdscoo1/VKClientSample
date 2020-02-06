//
//  PostCell.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    let topSeparator = UIView()
    let shadowPhotoView = ShadowPhotoView(image: .helen)
    let postAuthor = UILabel()
    let publishDate = UILabel()
    let moreButton = UIButton()
    let postText = UILabel()
    let postImageView = UIImageView(image: .postImage)
    let postFooter = PostFooter()
    
    var items: [Post] = Post.posts
    
    static let reuseId = "PostCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setPosts(post: Post) {
        postAuthor.text = post.author
        publishDate.text = post.publishDate
        postText.text = post.postText
        postImageView.image = UIImage(imageLiteralResourceName: post.postImage)
    }
    
    private func setupUI() {
        topSeparator.backgroundColor = .lightGray
        topSeparator.alpha = 0.3
        
        postAuthor.text = "Apple | iPhone | iPad"
        postAuthor.textColor = Constants.Colors.vkTheme
        postAuthor.font = .systemFont(ofSize: 16)
        
        publishDate.text = "вчера в \(Int.random(in: 10...23)):\(Int.random(in: 10...59))"
        publishDate.textColor = .lightGray
        publishDate.font = .systemFont(ofSize: 15)
        
        moreButton.setImage(.moreButton, for: .normal)
        
        postText.numberOfLines = 0
        postText.text = "adsasdasdasdkasjddasfdhkfkllhasfhdkjshfajsfhjkadfhjhjsafjhsakdfhjsadfhjshjdfhfjsdjhfjhskfshjfasjkfhahjskdfhjshdfjjhdfhjdhjkfdk"
        postText.backgroundColor = .white
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        addSubview(topSeparator)
        addSubview(shadowPhotoView)
        addSubview(postAuthor)
        addSubview(publishDate)
        addSubview(moreButton)
        addSubview(postText)
        addSubview(postImageView)
        addSubview(postFooter)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        shadowPhotoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowPhotoView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 16),
            shadowPhotoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shadowPhotoView.heightAnchor.constraint(equalToConstant: 40),
            shadowPhotoView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postAuthor.centerYAnchor.constraint(equalTo: shadowPhotoView.centerYAnchor, constant: -8),
            postAuthor.leadingAnchor.constraint(equalTo: shadowPhotoView.trailingAnchor, constant: 8),
            postAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publishDate.leadingAnchor.constraint(equalTo: postAuthor.leadingAnchor),
            publishDate.trailingAnchor.constraint(equalTo: postAuthor.trailingAnchor),
            publishDate.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 4)
        ])
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: postAuthor.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        postText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postText.topAnchor.constraint(equalTo: shadowPhotoView.bottomAnchor, constant: 16),
            postText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            postText.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postFooter.topAnchor)
        ])
        
        postFooter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postFooter.leadingAnchor.constraint(equalTo: leadingAnchor),
            postFooter.trailingAnchor.constraint(equalTo: trailingAnchor),
            postFooter.bottomAnchor.constraint(equalTo: bottomAnchor),
            postFooter.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

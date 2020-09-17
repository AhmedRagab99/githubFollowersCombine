//
//  FollowerCell.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class FollowerCell:UICollectionViewCell{
    static let reuseID = "followercell"
    let avatarImageView = GFCAvatarImageView(frame: .zero)
    let usernameLabel = GFCTitleLabel(textAlignment: .center, fontsize: 16)
    let padding:CGFloat = 8
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setFollower(follower:Follower){
        usernameLabel.text = follower.login
        let urlString =  follower.avatarUrl
        if let url = URL(string: urlString){
            avatarImageView.kf.indicatorType = .activity
            
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
            avatarImageView.kf.setImage(with: .network(url), placeholder: UIImage(named: "avatar-placeholder"),options: options)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

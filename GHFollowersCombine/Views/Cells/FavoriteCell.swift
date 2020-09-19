//
//  FavoriteCell.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/19/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher


class FavoriteCell:UITableViewCell{
    static let reuseID = "FavoriteCell"
    let avatarImageView = GFCAvatarImageView(frame: .zero)
    let usernameLabel = GFCTitleLabel(textAlignment: .left, fontsize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    func setFavorite(follower:Follower){
        usernameLabel.text = follower.login
        let urlString =  follower.avatarUrl
        if let url = URL(string: urlString){
            avatarImageView.kf.indicatorType = .activity
                    let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
            avatarImageView.kf.setImage(with: .network(url), placeholder: UIImage(named: "avatar-placeholder"),options: options)
        }
    }
    
    private func configure(){
        
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        accessoryType = .disclosureIndicator
        let padding:CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

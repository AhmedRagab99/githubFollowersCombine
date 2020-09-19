//
//  GFCUserInfoHeaderVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/16/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class GFCUserInfoHeaderVC: UIViewController {
    
    
    let avatarImageView = GFCAvatarImageView(frame: .zero)
    let userNameLabel = GFCTitleLabel(textAlignment: .left, fontsize: 34)
    let nameLabel = GFCSecondaryTitleLabel(fontsize: 18)
    let locationImageView = UIImageView()
    let loactionLabel = GFCSecondaryTitleLabel(fontsize: 18)
    let bioLabel = GFCBodyLabel(textAlignment: .left)
    var user :User!
    
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configureUiData()
    }
    
    private  func configureUiData(){
        
        if let url = URL(string: user.avatarUrl){
            avatarImageView.kf.indicatorType = .activity
            
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
            avatarImageView.kf.setImage(with: .network(url), placeholder: UIImage(named: "avatar-placeholder"),options: options)
        }
        
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = .secondaryLabel
        loactionLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No Bio Available"
        bioLabel.numberOfLines = 3
        
    }
    private func addSubViews(){
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(loactionLabel)
        view.addSubview(bioLabel)
    }
    
    private func layoutUI(){
        let padding : CGFloat = 20
        let imagePadding:CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // image
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: imagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: imagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            loactionLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            loactionLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            loactionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loactionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: imagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
            
        ] )
        
    }
    
    
    
}

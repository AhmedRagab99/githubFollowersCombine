//
//  GFCItemInfoView.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit



enum ItemInfoType {
    case repos,gists,followers,following
}
class GFCItemInfoView: UIView {
    
    let SFSymbolImage = UIImageView()
    let titleLabel = GFCTitleLabel(textAlignment: .left, fontsize: 14)
    let countLabel = GFCTitleLabel(textAlignment: .center, fontsize: 14)
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
//        addSubview(SFSymbolImage)
//        addSubview(titleLabel)
//        addSubview(countLabel)
       addSubViews(views: SFSymbolImage,titleLabel,countLabel)
        
        SFSymbolImage.translatesAutoresizingMaskIntoConstraints = false
        SFSymbolImage.tintColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            SFSymbolImage.topAnchor.constraint(equalTo: self.topAnchor),
            SFSymbolImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            SFSymbolImage.widthAnchor.constraint(equalToConstant: 20),
            SFSymbolImage.heightAnchor.constraint(equalToConstant: 20),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: SFSymbolImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: SFSymbolImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: SFSymbolImage.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
    
    func set(itemInfoType:ItemInfoType,with count:Int){
        self.countLabel.text = count.description
        switch itemInfoType{
        case .repos:
            self.SFSymbolImage.image = UIImage(systemName: SFSympols.repos)
            self.titleLabel.text = "Public Repos"
        case .gists:
            self.SFSymbolImage.image = UIImage(systemName: SFSympols.gists)
            self.titleLabel.text = "Public Gists"
        case .followers:
            self.SFSymbolImage.image = UIImage(systemName: SFSympols.followers)
            self.titleLabel.text = "Followers"
        case .following:
            self.SFSymbolImage.image = UIImage(systemName: SFSympols.following)
            self.titleLabel.text = "Following"
            
        }
    }
    
}

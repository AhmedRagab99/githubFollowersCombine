//
//  GFCAvatarImageView.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
class GFCAvatarImageView:UIImageView{
    let placeHodlerImage = UIImage(named: "avatar-placeholder")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHodlerImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}

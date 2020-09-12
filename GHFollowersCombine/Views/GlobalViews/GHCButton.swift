//
//  GFCButton.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/11/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit


class GFCButton:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not with storyboered")
    }
    
    init(backgroundColor:UIColor,title:String) {
        super.init(frame:.zero)
        self.backgroundColor =  backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure(){
        layer.cornerRadius = 15
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        titleLabel?.textColor = .label
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  GFCEmptyStateView.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/14/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit


class GFCEmptyStateView:UIView{
    
    
    let messageLabel = GFCTitleLabel(textAlignment: .center, fontsize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(message:String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure(){

        addSubViews(views: messageLabel,logoImageView)
      
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}

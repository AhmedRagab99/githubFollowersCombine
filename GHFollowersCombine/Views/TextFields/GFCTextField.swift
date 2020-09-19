//
//  GFCTextField.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/11/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class GHCTextField:UITextField{
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error here")
    }
    
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .default
    }
}

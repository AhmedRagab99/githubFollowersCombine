//
//  GFCSecondaryTitleLabel.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/16/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class GFCSecondaryTitleLabel: UILabel {

    
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
      }
      required init?(coder: NSCoder) {
          fatalError("error in here")
      }
      
      
      init(fontsize:CGFloat) {
          super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .medium)
          configure()
      }
      
      
      private func configure(){
          textColor = .secondaryLabel
          adjustsFontSizeToFitWidth = true
          minimumScaleFactor = 0.9
          lineBreakMode = .byTruncatingTail
          translatesAutoresizingMaskIntoConstraints = false
      }

}

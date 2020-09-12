//
//  ViewControllerExtenstions.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentGFCAlert(title:String,message:String,buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFCAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

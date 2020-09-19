//
//  ViewControllerExtenstions.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import SafariServices


fileprivate var  containerView:UIView!
fileprivate var activityIndicator = UIActivityIndicatorView(style: .large)
extension UIViewController{
    
    func presentGFCAlert(title:String,message:String,buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFCAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presenSafaryVC(url:URL) {
        let safaryVC = SFSafariViewController(url: url)
        safaryVC.preferredBarTintColor = .systemGreen
        self.present(safaryVC,animated: true)
    }
    
    func showEmptyStateView(message:String,in view:UIView){
        let emptyView = GFCEmptyStateView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
 
}
extension UIView{
    
     func addSubViews(views:UIView...){
         for view in views{
            addSubview(view)
         }
     }
}

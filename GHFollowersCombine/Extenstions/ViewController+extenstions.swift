//
//  ViewControllerExtenstions.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit


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
    
    func showEmptyStateView(message:String,in view:UIView){
        let emptyView = GFCEmptyStateView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
    
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.alpha = 0
        containerView.backgroundColor = .systemBackground
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        
      
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        activityIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            
        
        containerView.removeFromSuperview()
            containerView.alpha = 0
        }
    }
}

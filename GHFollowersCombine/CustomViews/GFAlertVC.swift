//
//  GFAlertVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit


class GFCAlertVC:UIViewController{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureAlertButtonTitle()
        configureBodyLabel()
    }

    let containerView = UIView()
    let titleLabel = GFCTitleLabel(textAlignment: .center, fontsize: 20)
    let messageLabel = GFCBodyLabel(textAlignment: .center)
    let actionButton = GFCButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle:String?
    var message:String?
    var buttonTitle:String?
    let padding :CGFloat = 20
    
    init(title:String,message:String,buttonTitle:String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
    private func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: padding+8)
        ])
    }
    
    private func configureAlertButtonTitle(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
        
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    @objc private func dismissVC(){
        self.dismiss(animated: true)
    }
    
    
    private func configureBodyLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete the proccess"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant:8 ),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor,constant:8 )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

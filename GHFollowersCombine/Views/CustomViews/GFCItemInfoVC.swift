//
//  GFCItemInfoVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class GFCItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let firstItemInfoView = GFCItemInfoView()
    let secondItemInfoView = GFCItemInfoView()
    let actionButton = GFCButton()
    var user :User!
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        layoutUI()
        setStackView()
        
    }
    
    
    private func setStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)
    }
    
    private  func layoutUI(){
        view.addSubViews(views: stackView,actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}

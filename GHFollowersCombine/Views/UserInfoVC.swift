//
//  UserInfoVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/16/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Combine


class UserInfoVC:UIViewController{
    
    
    var userName:String!
    var userViewModel  = UserInfoViewModel()
    let headerView = UIView()
    let firstView = UIView()
    let secondView = UIView()
    var itemViews = [UIView]()
    var indicator = UIActivityIndicatorView(style: .large)

    let dateLabel = GFCBodyLabel(textAlignment: .center)
    private var subscribers :Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
        configureIndicator()
        layoutUI()

        userViewModel.getUserData(userName: userName)
        
        subscribeToUser()
  
    }
    
    
    private func isLoadingSubscriber(){
        userViewModel.lodingState.sink { (val) in
            val == true ? self.indicator.startAnimating():self.indicator.stopAnimating()
            print(val)
            
        }
        .store(in: &subscribers)
    }
    
    private func subscribeToUser(){
          userViewModel.userInfo.sink(receiveCompletion: { (error) in
                print(error)
            }) { (user) in
                print(user)
                self.isLoadingSubscriber()
                self.add(childVC: GFCUserInfoHeaderVC(user: user), to: self.headerView)
                self.add(childVC: RepoItemVC(user: user), to: self.firstView)
                self.add(childVC: FollowerItemVC(user: user), to: self.secondView)
                self.dateLabel.text = "GitHub User Since \(user.createdAt.displayDateInString())"
            }
            .store(in: &subscribers)
            
        }
    
    
    private func configureController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModel))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureIndicator(){
          view.addSubview(indicator)
          indicator.translatesAutoresizingMaskIntoConstraints = false
          
    
          //print(followersViewModel.lodingState)
          NSLayoutConstraint.activate([
              indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
      }
    
    private func layoutUI(){
        
        itemViews = [headerView,firstView,secondView,dateLabel]
        
        itemViews.forEach { (itemView) in
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                
            ])
        }
        
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            
            firstView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 20),
            firstView.heightAnchor.constraint(equalToConstant: 140),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor,constant: 20),
            secondView.heightAnchor.constraint(equalToConstant: 140),
            
            
            dateLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
            
        ])
    }
    
    func add(childVC:UIViewController,to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    
    @objc private func dismissModel(){
        dismiss(animated: true)
    }
}

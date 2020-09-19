//
//  FollowerItemVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit


class FollowerItemVC:GFCItemInfoVC{
    
    var  userViewModel:UserInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(userViewModel:UserInfoViewModel,user:User) {
        super.init(user: user)
        self.userViewModel = userViewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItems(){
        firstItemInfoView.set(itemInfoType: .followers, with: user.followers)
        secondItemInfoView.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        actionButton.addTarget(self, action: #selector(changeUserFollopwersColloectionView), for: .touchUpInside)
    }
    
    
    @objc func changeUserFollopwersColloectionView(){
        userViewModel.isUserFollowersButtonTapped.send(true)
        print(userViewModel.isProfileButtonTapped.value)
        changeFollowers()
    }
    
    func changeFollowers(){
        if userViewModel.isUserFollowersButtonTapped.value == true {
            let vc = FollowersVC()
            vc.username = user.login
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

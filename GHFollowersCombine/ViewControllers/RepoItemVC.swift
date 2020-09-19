//
//  RepoItemVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.

import UIKit
import SafariServices


class RepoItemVC:GFCItemInfoVC{
    
    var userViewModel: UserInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    init(userViewModel:UserInfoViewModel,user:User) {
        super.init(user:user)
        self.userViewModel = userViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItems(){
        firstItemInfoView.set(itemInfoType: .repos, with: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        actionButton.addTarget(self, action: #selector(openUserProfileInSafary), for: .touchUpInside)
    }
    
    
    @objc func openUserProfileInSafary(){
        print("geefadf")
        userViewModel.isProfileButtonTapped.send(true)
        print(userViewModel.isProfileButtonTapped.value)
        openSafaryVC(for: user)
    }
    
    func openSafaryVC(for user:User){
        if userViewModel.isProfileButtonTapped.value == true {
            guard let url = URL(string: user.htmlUrl) else{
                self.presentGFCAlert(title: "Invalid URL!", message: "the url attached to this url is invalid", buttonTitle: "OK")
                return
            }
            presenSafaryVC(url: url)
        }
    }
}

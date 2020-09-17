//
//  RepoItemVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.

import UIKit


class RepoItemVC:GFCItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems(){
        firstItemInfoView.set(itemInfoType: .repos, with: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}

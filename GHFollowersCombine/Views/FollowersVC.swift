//
//  FollowersVC.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/12/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class FollowersVC:UIViewController{
    
    
    var userFollowers = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
         navigationController?.isNavigationBarHidden = false
        print(userFollowers.count)
       
}
    
}

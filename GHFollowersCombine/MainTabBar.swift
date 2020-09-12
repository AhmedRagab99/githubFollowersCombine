//
//  MainTabBar.swift
//  GHFollowersCombine
//
//  Created by Ahmed Ragab on 9/11/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit

class MainTabBar:UITabBarController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemGreen
        createControllers()
        
    }
    
    
    
    fileprivate func createControllers(){
        viewControllers = [
            createNavControllers(for: ViewController(), title: "Favurite", image: UIImage(systemName:"bookmark.fill")!)
,
            createNavControllers(for: SearchVC(), title: "Search", image: UIImage(systemName: "magnifyingglass")!)
        ]
    }
    
    
    fileprivate func createNavControllers(for rootViewController:UIViewController,title:String,image:UIImage)->UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        if title == "Profile"{
            rootViewController.navigationItem.title = ""
            
        }
        else{
            rootViewController.navigationItem.title = title
        }
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        UINavigationBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().prefersLargeTitles = true
        return navController
        
    }
}

//
//  TabBarViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 12/2/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

  

    lazy var profileVC = UINavigationController(rootViewController: ProfileViewController())
    
    lazy var feedVC = FeedViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 1)
        feedVC.tabBarItem =  UITabBarItem(title: "Feeds", image: nil, tag: 0)

        self.viewControllers = [profileVC, feedVC]
    }
    
    
    
}

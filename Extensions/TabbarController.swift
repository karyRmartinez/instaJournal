//
//  TabbarController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/26/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import Foundation
class TabBarVC: UITabBarController {

    lazy var ProfileVC = UINavigationController(rootViewController: ProfileViewController())
    
    lazy var FeedVC = UINavigationController(rootViewController: fee)
    
    lazy var profileVC: UINavigationController = {
        let userProfileVC = UserProfileViewController()
        userProfileVC.user = AppUser(from: FirebaseAuthService.manager.currentUser!)
        userProfileVC.isCurrentUser = true
        return UINavigationController(rootViewController: userProfileVC)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsVC.tabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "list.dash"), tag: 0)
        usersVC.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 2)
        self.viewControllers = [postsVC, usersVC,profileVC]
    }
}

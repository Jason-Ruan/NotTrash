//
//  NotTrashTabBar.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class NotTrashTabBar: UITabBarController {

    lazy var feedVC: UINavigationController = {
           let VC = HomeVC()
           return UINavigationController(rootViewController: VC)
       }()
       lazy var addVc: UINavigationController = {
           let VC = AddPostVC()
           return UINavigationController(rootViewController: VC)
       }()
    
   lazy var profileVC: UINavigationController = {
        let VC = UserProfileVC()
        return UINavigationController(rootViewController: VC)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [feedVC,addVc, profileVC]
    }
    


}

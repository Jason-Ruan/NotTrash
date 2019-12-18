//
//  AddPostVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToDetail()
    }
    var currentUser: AppUser?
    //MARK: - Variables
    
    //MARK: - UI Objects
    //MARK: - Objc Functions
    @objc private func gotoDetail(){
       navigationController?.pushViewController(PostDetailVC(), animated: true)
       }
    //MARK: - Regular Functions
    private func setUpView(){
        view.backgroundColor = .white
    }
    private func segueToDetail(){
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(gotoDetail))
    }
    //MARK: - Constraints
    
  
    

   

}

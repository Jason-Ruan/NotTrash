//
//  PostDetailVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController {
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Variables
    var postImages = [UIImage]()
    //MARK: - UI Objects
    lazy var postImage: UIPageControl = {
        let page = UIPageControl()
        page.layer.zPosition = 1
        page.numberOfPages = postImages.count
        page.currentPage = 0
        page.tintColor = UIColor.red
        page.pageIndicatorTintColor = UIColor.black
        page.currentPageIndicatorTintColor = UIColor.green
        return page
    }()
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    //MARK: - Constraints

}

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
    var postImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToDetail()
    }
    var currentUser: AppUser?
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var imageCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumInteritemSpacing = 0
           layout.itemSize = CGSize(width: view.frame.width, height: 400)
           
           let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3), collectionViewLayout: layout)
           cv.delegate = self
           cv.dataSource = self
           cv.register(ItemImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
           cv.isPagingEnabled = true
           return cv
       }()
       
       lazy var imagePageControl: UIPageControl = {
           let page = UIPageControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
           page.layer.zPosition = 1
           page.numberOfPages = postImages.count
           page.hidesForSinglePage = true
           page.backgroundColor = .clear
           page.currentPage = 0
           page.tintColor = UIColor.systemGray
           page.pageIndicatorTintColor = UIColor.darkGray
           page.currentPageIndicatorTintColor = UIColor.lightGray
           return page
       }()
    //MARK: - Objc Functions
    @objc private func gotoDetail(){
       navigationController?.pushViewController(PostDetailVC(), animated: true)}
    //MARK: - Regular Functions
    private func setUpView(){
        view.backgroundColor = .white
    }
    private func segueToDetail(){
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(gotoDetail))
    }
    //MARK: - Constraints
    private func constrainImageCollection(){
        view.addSubview(imageCollectionView)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            imageCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageCollectionView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.30)
        ])
    }
    private func constrainPageControl(){
        view.addSubview(imagePageControl)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           imagePageControl.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: -30),
           imagePageControl.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
           imagePageControl.widthAnchor.constraint(equalTo: imageCollectionView.widthAnchor),
           imagePageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
extension AddPostVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    

}
extension AddPostVC: UIScrollViewDelegate{
    
}

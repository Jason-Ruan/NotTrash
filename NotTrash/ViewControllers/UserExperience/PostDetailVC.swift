//
//  PostDetailVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController {
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
    
    
    //MARK: - Properties
    var postImages = ["THIS", "IS", "SPARTA!"]
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        addSubviews()
        applyAllConstraints()
    }
    
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(imagePageControl)
        view.addSubview(imageCollectionView)
    }
    
    private func applyAllConstraints() {
        constrainImageCollectionView()
        constrainPageControl()
    }
    
    private func constrainImageCollectionView() {
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func constrainPageControl() {
        imagePageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePageControl.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: -30),
            imagePageControl.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
            imagePageControl.widthAnchor.constraint(equalTo: imageCollectionView.widthAnchor),
            imagePageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    //MARK: - Constraints
    
}


//MARK: - CollectionView Methods
extension PostDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ItemImageCollectionViewCell
        cell.cardLabel.text = postImages[indexPath.row]
        return cell
    }
}


//MARK: - PageControl Methods
extension PostDetailVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        imagePageControl.currentPage = Int(pageNumber)
    }
}

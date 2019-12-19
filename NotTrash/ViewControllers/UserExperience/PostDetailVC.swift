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
        page.pageIndicatorTintColor = UIColor.lightGray
        page.currentPageIndicatorTintColor = UIColor.blue
        return page
    }()
    
    lazy var postCreatorNameLabel: UILabel = {
        let label = UILabel()
        if let posterName = self.itemListing?.creatorID {
            label.text = posterName
        }
        return label
    }()
    
    lazy var badgeImageView: UIImageView = {
        let iv = UIImageView()
        if let badge = self.badge {
            iv.image = badge
        }
        return iv
    }()
    
    lazy var messageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Message", for: .normal)
        button.addTarget(self, action: #selector(pingGifter), for: .touchUpInside)
        return button
    }()
    
    lazy var additionalItemInfo: UITextView = {
        let tv = UITextView()
        if let itemListing = self.itemListing {
            tv.text = itemListing.description
        }
        tv.isEditable = false
        return tv
    }()
    
    //MARK: - Optional Time Left Label
    //    lazy var timeLeftLabel: UILabel = {
    //       let label = UILabel()
    //        if let itemCreationDate = self.itemListing?.dateCreated {
    //            //Creates string formatting for date objects
    //            let dateComponentsFormatter = DateComponentsFormatter()
    //            dateComponentsFormatter.allowedUnits = [.day, .hour, .minute]
    //            dateComponentsFormatter.unitsStyle = .abbreviated
    //
    //            let dateFormatter = ISO8601DateFormatter()
    //            dateFormatter.formatOptions = [.withFullDate, .withSpaceBetweenDateAndTime]
    //
    //            //Creates last day for item listing
    //            var deadlineDateComponents = DateComponents()
    //            deadlineDateComponents.day = 7
    //            var deadline = Calendar.current.date(byAdding: deadlineDateComponents, to: itemCreationDate)
    //
    //            //Changes text of label to reflect remaining time
    //            if let deadline = deadline, let timeLeft = dateComponentsFormatter.string(from: itemCreationDate, to: deadline) {
    //                label.text = timeLeft
    //            }
    //        }
    //        return label
    //    }()
    
    
    //MARK: - Properties
    var itemListing: Post? {
        didSet {
            guard let creatorID = self.itemListing?.creatorID, let arrImagesURLStrings = self.itemListing?.imageURLStrings else {
                print("Did not get itemListing dEtails")
                return
            }
            
            self.badge = UIImage(named: "Trophy")
            
            var retrievedImages = [UIImage]()
            let dispatchGroup = DispatchGroup()
            
            arrImagesURLStrings.forEach { (urlString) in
                dispatchGroup.enter()
                FireStore.postManager.getImages(profileUrl: urlString) { (result) in
                    switch result {
                    case .success(let imageData):
                        guard let image = UIImage(data: imageData) else { return }
                        retrievedImages.append(image)
                        
                        dispatchGroup.leave()
                    case .failure(let error):
                        print("There was an error trying to retrieve imageData from PostDetailVC\nError:\(error)")
                        dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.postImages = retrievedImages
            }
        }
    }
    
    var poster: AppUser? {
        didSet {
            self.badge = UIImage(named: "Trophy")
        }
    }
    var badge: UIImage?
    var postImages = [UIImage]() {
        didSet {
            print(self.postImages.count)
            imageCollectionView.reloadData()
            view.addSubview(imagePageControl)
            constrainPageControl()
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        addSubviews()
        applyAllConstraints()
    }
    
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(imageCollectionView)
        view.addSubview(postCreatorNameLabel)
        view.addSubview(badgeImageView)
        view.addSubview(additionalItemInfo)
        view.addSubview(messageButton)
    }
    
    private func applyAllConstraints() {
        constrainImageCollectionView()
        constrainPosterName()
        constrainBadgeImageView()
        constrainAdditionalItemInfoTextView()
        constrainMessageButton()
    }
    
    private func constrainImageCollectionView() {
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageCollectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 3)
        ])
    }
    
    private func constrainPageControl() {
        imagePageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePageControl.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 10),
            imagePageControl.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
            imagePageControl.widthAnchor.constraint(equalTo: imageCollectionView.widthAnchor),
            imagePageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func constrainPosterName() {
        postCreatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postCreatorNameLabel.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 30),
            postCreatorNameLabel.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
            postCreatorNameLabel.widthAnchor.constraint(equalTo: imageCollectionView.widthAnchor, constant: -30),
            postCreatorNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constrainBadgeImageView() {
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgeImageView.topAnchor.constraint(equalTo: postCreatorNameLabel.bottomAnchor, constant: 10),
            badgeImageView.leadingAnchor.constraint(equalTo: postCreatorNameLabel.leadingAnchor),
            badgeImageView.widthAnchor.constraint(equalToConstant: 30),
            badgeImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constrainAdditionalItemInfoTextView() {
        additionalItemInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalItemInfo.topAnchor.constraint(equalTo: badgeImageView.bottomAnchor, constant: 10),
            additionalItemInfo.leadingAnchor.constraint(equalTo: badgeImageView.leadingAnchor),
            additionalItemInfo.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30),
            additionalItemInfo.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func constrainMessageButton() {
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageButton.bottomAnchor.constraint(equalTo: additionalItemInfo.bottomAnchor, constant: 30),
            messageButton.centerXAnchor.constraint(equalTo: additionalItemInfo.centerXAnchor),
            messageButton.widthAnchor.constraint(equalToConstant: 100),
            messageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    //MARK: - Objc Functions
    @objc func pingGifter() {
        //MARK: TODO - send preset message to gifter
        //var presetMessage = "This message is in response to your item listing on NotTrash for order \(itemListing.itemID)."
    }
    
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
        cell.imageView.image = postImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


//MARK: - PageControl Methods
extension PostDetailVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        imagePageControl.currentPage = Int(pageNumber)
    }
}

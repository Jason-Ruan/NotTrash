//
//  AddPostVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit
import Photos

class AddPostVC: UIViewController {
    //MARK: - Lifecycle
    var postImages = [UIImage](){
        didSet{
            imageCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToDetail()
        setUpView()
        setUpContraints()
        getImagePermission()
    }
    
    
    //MARK: - Variables
    let imagePickerViewController = UIImagePickerController()
    var currentUser: AppUser?
    //MARK: - UI Objects
    
    
    lazy var imageCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumInteritemSpacing = 0
           layout.itemSize = CGSize(width: view.frame.width, height: 400)
           
           let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
           cv.delegate = self
           cv.dataSource = self
        cv.backgroundColor = .blue
           cv.register(ItemImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
           cv.isPagingEnabled = true
           return cv
       }()
       
    
       lazy var imagePageControl: UIPageControl = {
           let page = UIPageControl()
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
    
    
    
    lazy var desriptionTextView: UITextView = {
        var view = UITextView()
        view.backgroundColor = .systemTeal
        return view
    }()
    
    
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    
    lazy var libraryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setImage(UIImage(systemName: "folder"), for: .normal)
        button.addTarget(self, action: #selector(presentPhotoPickerController), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Objc Functions
    
    
    @objc private func gotoDetail(){
       navigationController?.pushViewController(PostDetailVC(), animated: true)}
    
    
   

    
    
    //MARK: - Regular Functions
    func getImagePermission(){
           switch PHPhotoLibrary.authorizationStatus(){
           case .notDetermined, .denied , .restricted:
               PHPhotoLibrary.requestAuthorization({ status in
                   switch status {
                   case .authorized:
                       print("success")
                   case .denied:
                       print("Denied photo library permissions")
                   default:
                       print("No usable status")
                   }
               })
           default:
        print("success")
           }
       }
    
    @objc private func presentPhotoPickerController() {
           self.imagePickerViewController.delegate = self
           self.imagePickerViewController.sourceType = .photoLibrary
           self.imagePickerViewController.allowsEditing = true
           self.imagePickerViewController.mediaTypes = ["public.image"]
           self.present(self.imagePickerViewController, animated: true, completion: nil)
       }
    
    private func setUpView(){
        view.backgroundColor = .white
    }
    
    private func segueToDetail(){
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(gotoDetail))
    }
    
    private func setUpContraints(){
       constraintButtonStackView()
        constrainDescriptionView()
        constrainImageCollection()
        constrainPageControl()
    }
    
    //MARK: - Constraints
    private func constrainDescriptionView(){
    view.addSubview(desriptionTextView)
    desriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        desriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
        desriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        desriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        desriptionTextView.heightAnchor.constraint(equalToConstant: 150)
    ])}
     private func constrainImageCollection() {
        view.addSubview(imageCollectionView)
          imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            imageCollectionView.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: 0),
              imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              imageCollectionView.heightAnchor.constraint(equalToConstant: 400)
          ])
      }
      
      private func constrainPageControl() {
        view.addSubview(imagePageControl)
          imagePageControl.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              imagePageControl.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: -30),
              imagePageControl.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
              imagePageControl.widthAnchor.constraint(equalTo: imageCollectionView.widthAnchor),
              imagePageControl.heightAnchor.constraint(equalToConstant: 20)
          ])
      }
    private func constraintButtonStackView(){
        let stackView = UIStackView(arrangedSubviews: [cameraButton, libraryButton])
                   stackView.axis = .horizontal
                   stackView.spacing = 0
        stackView.backgroundColor = .lightGray
                   stackView.distribution = .fillEqually
                   view.addSubview(stackView)
                   stackView.translatesAutoresizingMaskIntoConstraints = false
                   NSLayoutConstraint.activate([
                    stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                       stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                       stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                       stackView.heightAnchor.constraint(equalToConstant: 80)])
    }
    
    
}
extension AddPostVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ItemImageCollectionViewCell
        let data = postImages[indexPath.row]
        cell.imageView.image = data
        return cell
    }
}
extension AddPostVC: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
          imagePageControl.currentPage = Int(pageNumber)
      }
}
extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            postImages.append(image)
        }else {print("no image")}
        dismiss(animated: true)
    }
}

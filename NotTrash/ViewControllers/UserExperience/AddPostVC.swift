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
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpContraints()
        getImagePermission()
    }
    
    
    //MARK: - Variables
    var postImages = [UIImage](){
           didSet{
               imageCollectionView.reloadData()
               
           }
       }
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
    
    
    lazy var descriptionTextView: UITextView = {
        var view = UITextView()
        view.backgroundColor = .systemTeal
        return view
    }()
    
    
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(presenCameraController), for: .touchUpInside)
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
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePost))
        return button
    }()
    
    
    
    //MARK: - Objc Functions
    @objc private func presentPhotoPickerController() {
          self.imagePickerViewController.delegate = self
          self.imagePickerViewController.sourceType = .photoLibrary
          self.imagePickerViewController.allowsEditing = true
          self.imagePickerViewController.mediaTypes = ["public.image"]
          self.present(self.imagePickerViewController, animated: true, completion: nil)
      }
      @objc private func presenCameraController() {
          self.imagePickerViewController.delegate = self
          self.imagePickerViewController.sourceType = .camera
          self.imagePickerViewController.allowsEditing = true
          self.imagePickerViewController.mediaTypes = ["public.image"]
          self.present(self.imagePickerViewController, animated: true, completion: nil)
      }
      
    @objc private func savePost(){
        if descriptionTextView.text.isEmpty && postImages.count == 0{
            showAlert(with: "", and: "Please fill out fields")
        }else {
        
        saveButton.isEnabled = false
        var imageData = [Data]()
        for i in postImages{
            if let selectedData = i.jpegData(compressionQuality: 0.3){
                imageData.append(selectedData)
        }
        }
        FireStore.postManager.storeImage(image: imageData, completion: {  (result) in
            switch result{
            case .success(let urls):
                print(urls)
                let post = Post(from: self.currentUser!, borough: "queens", imageURLStrings: urls, description: self.descriptionTextView.text, isAvailable: true)
                
                FireService.manager.createPost(post: post) { (result) in
                    switch result{
                    case .success(()):
                        self.saveButton.isEnabled = true
                    case .failure(let error):
                        print(error)
                    }}
                
            case .failure(let error):
                print(error)
            }
        })
        }}
    
    
    
    
    //MARK: - Regular Functions
    private func setUpView(){
         view.backgroundColor = .white
         navigationItem.rightBarButtonItem = saveButton
     }
     
     private func showAlert(with title: String, and message: String) {
                    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(alertVC, animated: true, completion: nil)
                }
   private func getImagePermission(){
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
    private func setUpContraints(){
         constraintButtonStackView()
         constrainDescriptionView()
         constrainImageCollection()
         constrainPageControl()
     }
  
    
    
    //MARK: - Constraints
    private func constrainDescriptionView(){
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])}
    private func constrainImageCollection() {
        view.addSubview(imageCollectionView)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCollectionView.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: 0),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollectionView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor)
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
//MARK: - CollectionView Delegates
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


//MARK: - UIScrollViewDelegate
extension AddPostVC: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        imagePageControl.currentPage = Int(pageNumber)
    }
}    

//MARK: - UIImagePickerControllerDelegate
extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            postImages.append(image)
        }else {print("no image")}
        dismiss(animated: true)
    }
}

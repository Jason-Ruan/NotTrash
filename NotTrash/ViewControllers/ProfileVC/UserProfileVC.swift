//
//  userProfileVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    

        var photoLibraryAccess = false
    var image = UIImage() {
        didSet {
           profileImage.image = image
        }
    }


    
    
      var rewardImage: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named: "Trophy")
           image.contentMode = .scaleAspectFill
       return image
           }()
       
        
  lazy var addImageButton: UIButton = {
           let button = UIButton()
           button.setTitle("Edit", for: .normal)
           button.setTitleColor(.purple, for: .normal)
           button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 12)
    button.backgroundColor = .clear
           button.layer.cornerRadius = 5
           button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
           return button
       }()


    var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileIcon")
        image.contentMode = .scaleAspectFill
//        image.layer.cornerRadius = image.frame.size.width/2
        image.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        image.layer.borderWidth = 3.0
        image.layer.cornerRadius = 100
           
    
        return image
        }()
    
    lazy var BioTextView: UITextView = {
         let textView = UITextView()
         textView.font = UIFont(name: "Verdana", size: 14)
         textView.backgroundColor = .white
        textView.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        textView.layer.borderWidth = 3.0
         textView.layer.cornerRadius = 5
        textView.autocorrectionType = .no
         return textView
     }()
    
    lazy var ContactButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        return button
    }()
    
   
    
    @objc private func addImagePressed() {
   let imagePickerViewController = UIImagePickerController()
     imagePickerViewController.delegate = self
     imagePickerViewController.sourceType = .photoLibrary
     
     if photoLibraryAccess {
         imagePickerViewController.delegate = self
         present(imagePickerViewController, animated: true, completion: nil)
     } else {
         let alertVC = UIAlertController(title: "No Access", message: "Camera access is required to use this app.", preferredStyle: .alert)
         alertVC.addAction(UIAlertAction (title: "Deny", style: .destructive, handler: nil))
         self.present(alertVC, animated: true, completion: nil)
         
         alertVC.addAction(UIAlertAction (title: "I will let you in", style: .default, handler: { (action) in
             self.photoLibraryAccess = true
             self.present(imagePickerViewController, animated: true, completion: nil)
         }))
     }
        
    }
    
    
    
    private func presentPhotoPickerController() {
           DispatchQueue.main.async{
               let imagePickerViewController = UIImagePickerController()
               imagePickerViewController.delegate = self
               imagePickerViewController.sourceType = .photoLibrary
               imagePickerViewController.allowsEditing = true
               imagePickerViewController.mediaTypes = ["public.image"]
               self.present(imagePickerViewController, animated: true, completion: nil)
           }
       }

      
    private func setImageConstraints() {
         view.addSubview(profileImage)
         profileImage.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             profileImage.widthAnchor.constraint(equalToConstant: 200),
             profileImage.heightAnchor.constraint(equalToConstant: 200)])
     }
    
  private func setADDImageConstraints() {
         view.addSubview(addImageButton)
         addImageButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             addImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             addImageButton.widthAnchor.constraint(equalToConstant: 40),
             addImageButton.heightAnchor.constraint(equalToConstant: 40)])
     }
    
    private func setTextFieldConstraints() {
          BioTextView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              BioTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            BioTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
           BioTextView.widthAnchor.constraint(equalToConstant: 300),
            BioTextView.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    private func   setRewardImageConstraints() {
         rewardImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              rewardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rewardImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
           rewardImage.widthAnchor.constraint(equalToConstant: 50),
            rewardImage.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    
    
    private func Addsubviews() {
        self.view.addSubview(profileImage)
        self.view.addSubview(BioTextView)
            self.view.addSubview(rewardImage)
        self.view.addSubview(addImageButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Addsubviews()
        setImageConstraints()
        setTextFieldConstraints()
      setRewardImageConstraints()
        setADDImageConstraints()
     
        // Do any additional setup after loading the view.
    }

    

}
extension UserProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}


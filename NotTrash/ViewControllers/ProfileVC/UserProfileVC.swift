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
       
    
    
    var rewardStarImage: UIImageView = {
             let image = UIImageView()
             image.image = UIImage(named: "Star")
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
    
    
    lazy var PointsButton: UIButton = {
        let button = UIButton()
        button.setTitle("75/200", for: .normal)
        button.layer.cornerRadius = 6
        button.setTitleColor(.purple, for: .normal)
               button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var nextReward: UILabel = {
        let label = UILabel()
        label.text = " Your next Reward! "
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.backgroundColor = .white
        return label
    
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
             profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -125),
             profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             profileImage.widthAnchor.constraint(equalToConstant: 50),
             profileImage.heightAnchor.constraint(equalToConstant: 50)])
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
            BioTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
           BioTextView.widthAnchor.constraint(equalToConstant: 300),
            BioTextView.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    private func setNextRewardConstraints() {
          nextReward.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              nextReward.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextReward.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 320),
           nextReward.widthAnchor.constraint(equalToConstant: 150),
            nextReward.heightAnchor.constraint(equalToConstant: 20)
          ])
      }
    
    
    
    private func   setRewardImageConstraints() {
    rewardImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rewardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
        rewardImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 320),
         rewardImage.widthAnchor.constraint(equalToConstant: 30),
          rewardImage.heightAnchor.constraint(equalToConstant: 15)
        ])
      }
   //MARK: progressBar
    
    lazy var CircularProgress: CircularProgressView = {
         let view = CircularProgressView()
//        view.trackColor = UIColor.red
//
   view.tintColor = UIColor.purple
        view.backgroundColor = .white
view.setProgressWithAnimation(duration: 1.0, value: 0.3)
     
         return  view
     }()
    
    
    private func   setProgressbarConstraints() {
CircularProgress.translatesAutoresizingMaskIntoConstraints = false
             
       CircularProgress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CircularProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CircularProgress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        CircularProgress.widthAnchor.constraint(equalToConstant: 5),
         CircularProgress.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func animateProgress() {
         let cP = self.view.viewWithTag(101) as! CircularProgressView
         cP.setProgressWithAnimation(duration: 1.0, value: 0.7)
         
     }
    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
    
    //
    
    private func  pointsconstraints() {
         PointsButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
             PointsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            PointsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
           PointsButton.widthAnchor.constraint(equalToConstant: 150),
           PointsButton.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    
    
    private func  Starpointsconstraints() {
         rewardStarImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
             rewardStarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            rewardStarImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
          rewardStarImage.widthAnchor.constraint(equalToConstant: 40),
          rewardStarImage.heightAnchor.constraint(equalToConstant: 40)
          ])
      }
    
    
    
    private func Addsubviews() {
        self.view.addSubview(profileImage)
        self.view.addSubview(BioTextView)
            self.view.addSubview(rewardImage)
        self.view.addSubview(addImageButton)
        self.view.addSubview(PointsButton)
        self.view.addSubview(rewardStarImage)
        self.view.addSubview(CircularProgress)
        self.view.addSubview(nextReward)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Addsubviews()
        setImageConstraints()
        setTextFieldConstraints()
      setRewardImageConstraints()
        setADDImageConstraints()
        pointsconstraints()
        Starpointsconstraints()
        setProgressbarConstraints()
        setNextRewardConstraints()
        
      
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


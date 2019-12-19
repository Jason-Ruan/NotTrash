//
//  LoginVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
             super.viewDidLoad()
             setupSubViews()
        setupTrashLogo()
         }
         // MARK: - UI objects
         
         lazy var notTrashLogo: UILabel = {
             let label = UILabel()
             label.text = "NotTrash"
             label.font = UIFont(name: "Verdana-Bold", size: 40)
             label.textColor = #colorLiteral(red: 0.2564295232, green: 0.4383472204, blue: 0.8055806756, alpha: 1)
             label.textAlignment = .center
             return label
         }()
         
    var rewardStarImage: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "goldTrash")
                image.contentMode = .scaleAspectFill
       
            return image
                }()
       
    
    
         lazy var emailTextField: UITextField = {
             let field = UITextField()
             field.placeholder = "Enter email"
             field.font = UIFont(name: "Verdana", size: 14)
             field.borderStyle = .bezel
             field.backgroundColor = .white
             field.autocorrectionType = .no
             return field
         }()
         lazy var passwordTextField: UITextField = {
             let field = UITextField()
             field.placeholder = "Enter Password"
             field.font = UIFont(name: "Verdana", size: 14)
             field.borderStyle = .bezel
             field.backgroundColor = .white
             field.autocorrectionType = .no
             field.isSecureTextEntry = true
             return field
         }()
         lazy var loginButton: UIButton = {
             let button = UIButton(type: .system)
             button.setTitle("Login", for: .normal)
             button.setTitleColor(.white, for: .normal)
             button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
             button.backgroundColor = #colorLiteral(red: 0.2565537095, green: 0.4382570684, blue: 0.8097142577, alpha: 1)
             button.layer.cornerRadius = 5
             button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
             return button
         }()
         lazy var createAccount: UIButton = {
             let button = UIButton(type: .system)
             let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ",
                                                             attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
                                                                          NSAttributedString.Key.foregroundColor: UIColor.white])
             
             attributedTitle.append(NSAttributedString(string: "Sign Up",attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana-Bold", size: 14)!,
                                                                                      NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
             button.setAttributedTitle(attributedTitle, for: .normal)
             button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
             return button
         }()
         
         
         //MARK: - Objc functions
         
         @objc func loginAction(){
             guard let email = emailTextField.text, let password = passwordTextField.text else {
                 showAlert(title: "Error", message: "Please fill out all fields.")
                 return
             }
             guard email.isValidEmail else {
                 showAlert(title: "Error", message: "Please enter a valid email")
                 return
             }
             guard password.isValidPassword else {
                 showAlert(title: "Error", message: "Please enter a valid password. Passwords must have at least 8 characters.")
                 return
             }
             
             FireAuth.manager.loginUser(email: email.lowercased(), password: password) { (result) in
                 self.handleLoginResponse(with: result)
             }
         }
         @objc func showSignUp() {
             let signupVC = SignUpVC()
             signupVC.modalPresentationStyle = .formSheet
             present(signupVC, animated: true, completion: nil)
         }
         
         
         //MARK: Regular VC functions
         private func setupSubViews() {
             view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.9216746795)
             emailTextField.delegate = self
             passwordTextField.delegate = self
             setupPursuitGramLogo()
             setupCreateAccountButton()
             setupLoginStack()
         }
         
         
         
         private func handleLoginResponse(with result: Result<(), Error>) {
             switch result {
             case .failure(let error):
                 showAlert(title: "Error", message: "Could not log in. Error: \(error)")
             case .success:
                 guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                     let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                     else {
                         return
                 }
                 UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                     window.rootViewController = NotTrashTabBar()
                 }, completion: nil)
             }
         }
         
         private func showAlert(title: String, message: String) {
             let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
             alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
             present(alertVC, animated: true)
         }
         
         //MARK: - UI Constraints
         private func setupPursuitGramLogo() {
             view.addSubview(notTrashLogo)
             notTrashLogo.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 notTrashLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
                 notTrashLogo.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                 notTrashLogo.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)])
         }
    
    private func setupTrashLogo() {
         view.addSubview(rewardStarImage)
  rewardStarImage.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
          rewardStarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        rewardStarImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
        rewardStarImage.widthAnchor.constraint(equalToConstant: 100),
        rewardStarImage.heightAnchor.constraint(equalToConstant: 15)
       ])
     }
     
    
    
         
         private func setupLoginStack() {
             let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,loginButton])
             stackView.axis = .vertical
             stackView.spacing = 15
             stackView.distribution = .fillEqually
             
             view.addSubview(stackView)
             stackView.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 stackView.topAnchor.constraint(equalTo: notTrashLogo.bottomAnchor, constant: 150),
                 stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                 stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                 stackView.heightAnchor.constraint(equalToConstant: 130)])
         }
         private func setupCreateAccountButton() {
             view.addSubview(createAccount)
             createAccount.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 createAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 createAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 createAccount.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                 createAccount.heightAnchor.constraint(equalToConstant: 50)])
         }
     }
     extension LoginVC: UITextFieldDelegate{
         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
         }
     }

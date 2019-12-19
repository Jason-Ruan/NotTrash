//
//  PostCell.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class PostTableCell: UITableViewCell {
    //MARK: - Property Objects
    lazy var userImage: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    lazy var username: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var itemPhoto: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCellSubviews()
        setUpCellConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    func configureCell(post: Post) {
        descriptionTextView.text = post.description
        
        print(post.imageURLStrings.count)
        print(post)
        
        guard let image = post.imageURLStrings.first else {
            return
        }
        FireStore.postManager.getImages(profileUrl: image) { (result) in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    print("FAILED CONVERTING DATA TO UIIMAGE")
                    return
                }
                self.itemPhoto.image = image
            case.failure(let error):
                print(error)
            }
        }
        username.text = "USER"
        userImage.image = UIImage(systemName: "person")
    }
    
    private func addCellSubviews() {
        self.addSubview(userImage)
        self.addSubview(username)
        self.addSubview(itemPhoto)
        self.addSubview(descriptionTextView)
    }
    
    private func setUpCellConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            userImage.widthAnchor.constraint(equalToConstant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        username.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            username.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 5),
            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            username.widthAnchor.constraint(equalToConstant: 100),
            username.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            descriptionTextView.topAnchor.constraint(equalTo: itemPhoto.topAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            descriptionTextView.leadingAnchor.constraint(equalTo: itemPhoto.trailingAnchor, constant: 5)
        ])
        
        itemPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemPhoto.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
            itemPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            itemPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            itemPhoto.widthAnchor.constraint(equalToConstant: 200)
        
        ])
    }
}

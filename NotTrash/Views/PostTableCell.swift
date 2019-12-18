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
        
        return textView
    }()
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    private func addCellSubviews() {
        
    }
    
    private func setUpCellConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            userImage.widthAnchor.constraint(equalToConstant: 30),
            userImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

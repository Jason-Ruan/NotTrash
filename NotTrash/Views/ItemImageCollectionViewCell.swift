//
//  ItemImageCollectionViewCell.swift
//  NotTrash
//
//  Created by Jason Ruan on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ItemImageCollectionViewCell: UICollectionViewCell {
    //MARK: UI Objects
    lazy var cardLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
//    lazy var optionsButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
//        button.setImage(UIImage(named: "more-filled"), for: .normal)
//        button.backgroundColor = .blue
//        button.layer.cornerRadius = button.frame.height / 2
//        return button
//    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: self.contentView.frame)
        iv.alpha = 0.2
        return iv
    }()
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private Functions
    private func addSubviews() {
//        contentView.addSubview(imageView)
        contentView.addSubview(cardLabel)
        contentView.backgroundColor = .systemYellow
//        contentView.addSubview(optionsButton)
    }
    
    private func constrainSubviews() {
//        constrainImageView()
        constrainLabel()
//        constrainButton()
    }
    
    
    //MARK: Constraints
    private func constrainImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func constrainLabel() {
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            cardLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height - 50)
        ])
    }
    
//    private func constrainButton() {
//        optionsButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
//            optionsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            optionsButton.widthAnchor.constraint(equalToConstant: 50),
//            optionsButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
    
    
}

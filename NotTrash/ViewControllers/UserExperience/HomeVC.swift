//
//  HomeVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    //MARK: - Property Objects
    
    lazy var boroughControl: UISegmentedControl = {
        let control = UISegmentedControl()
        setUpControlSegments(control: control)
        control.backgroundColor = .orange
        return control
    }()
    
    lazy var postTableView: UITableView = {
        let tableview = UITableView()
        
        return tableview
    }()
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        addSubviews()
        setUpConstraints()
    }
    
    //MARK: - Functions
    
    private func addSubviews() {
        self.view.addSubview(boroughControl)
        self.view.addSubview(postTableView)
    }
    
    private func setUpControlSegments(control: UISegmentedControl) {
        control.insertSegment(withTitle: "Manhattan", at: 0, animated: true)
        control.insertSegment(withTitle: "Brooklyn", at: 1, animated: true)
        control.insertSegment(withTitle: "Bronx", at: 2, animated: true)
        control.insertSegment(withTitle: "Queens", at: 3, animated: true)
        control.insertSegment(withTitle: "Staten Isle", at: 4, animated: true)
        
    }
    
    
    //MARK: - Constraints
    
    func setUpConstraints() {
        
        boroughControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boroughControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boroughControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            boroughControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            boroughControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            boroughControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: self.boroughControl.bottomAnchor, constant: 10),
            postTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            postTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        ])
    }
    
}

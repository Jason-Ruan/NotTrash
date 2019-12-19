//
//  HomeVC.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

enum CellIdentifier: String {
    case PostTableCell
}

class HomeVC: UIViewController {
    //MARK: - Property Objects
    
    lazy var boroughControl: UISegmentedControl = {
        let control = UISegmentedControl()
        setUpControlSegments(control: control)
        control.backgroundColor = .orange
        control.selectedSegmentIndex = 0
        return control
    }()
    
    lazy var postTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(PostTableCell.self, forCellReuseIdentifier: CellIdentifier.PostTableCell.rawValue)
        return tableview
    }()
    
    //MARK: - Properties
    
    var posts = [Post]() {
        didSet {
            postTableView.reloadData()
        }
    }
    
    let tests = [("CRAB_LOVER","THIS IS A PICTURE OF A CRAB I WILL GIVE THIS CRAB AWAY FOR FREE"),("bInchBO1", "i found this banana on the side of the road im giving it away bcause i believe in 0 waste"),("nickage","REAL: Declaration of Independence. LIMITED!!! ONLY 1 IN STOCK.")]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        addSubviews()
        setUpConstraints()
        setUpDelegates()
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
    
    private func setUpDelegates() {
        postTableView.delegate = self
        postTableView.dataSource = self
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let post = posts[indexPath.row]
        let test = tests[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PostTableCell.rawValue) as? PostTableCell {
            cell.descriptionTextView.text = test.1
            cell.username.text = test.0
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}

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
        control.backgroundColor = .clear
        control.selectedSegmentIndex = 0
        return control
    }()
    
    lazy var postTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(PostTableCell.self, forCellReuseIdentifier: CellIdentifier.PostTableCell.rawValue)
        tableview.backgroundColor = .clear
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
        self.view.setGradient(cgColors: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)])
        addSubviews()
        setUpConstraints()
        setUpDelegates()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         loadData()
    }
    //MARK: - Functions
    
    func loadData() {
        FireService.manager.getAllPost { (result) in
            switch result {
            case .success(let post):
                self.posts = post
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
            boroughControl.heightAnchor.constraint(equalToConstant: 30)
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PostTableCell.rawValue) as? PostTableCell {
            let post = posts[indexPath.row]
            
            cell.configureCell(post: post)
            cell.backgroundColor = .white
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PostDetailVC()
        detailVC.itemListing = posts[indexPath.row]
        present(detailVC, animated: true)
    }
    
}

extension UIView {
    public func setGradient(cgColors colors: [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: -1.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


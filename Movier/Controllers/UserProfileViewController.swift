//
//  UserProfileViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 31/10/24.
//

import Foundation
import UIKit

class UserProfileViewController : UIViewController {
    
    let userProfileView = UserProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userProfileView)
        
        userProfileView.tableView.dataSource = self
        userProfileView.tableView.delegate  = self
        userProfileView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        userProfileView.tableView.separatorColor = .white
        userProfileView.tableView.rowHeight = UITableView.automaticDimension
        userProfileView.tableView.estimatedRowHeight = 200
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension UserProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 1:
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "stree2")
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 200),
                imageView.widthAnchor.constraint(equalToConstant: 200),
            ])
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

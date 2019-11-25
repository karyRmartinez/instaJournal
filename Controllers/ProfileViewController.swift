//
//  ProfileViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/25/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var settingFromLogin = false

    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        label.text = "Profile"
        return label
    }()

    private func setupHeaderLabel() {
           view.addSubview(profileLabel)
           
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               profileLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
             profileLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
           profileLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
               profileLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)])
       }
       
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderLabel()

    }


}

//
//  ViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/22/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    
    
    lazy var BrandLabel: UILabel = {
         let label = UILabel()
         label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         label.text = "Pursuitstagram"
         label.font = UIFont(name: "Optima-BOld", size: 35)
         label.backgroundColor = .white
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
     func setBrandLabel() {
    NSLayoutConstraint.activate([
             BrandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             BrandLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
             BrandLabel.widthAnchor.constraint(equalToConstant: 130),
             BrandLabel.heightAnchor.constraint(equalToConstant: 35)
         ])
     }
     

    //MARK: AddSubViews
    
    private func  AddSubViews() {
        self.view.addSubview(BrandLabel)

    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBrandLabel()
        
        
        // Do any additional setup after loading the view.
    }


}


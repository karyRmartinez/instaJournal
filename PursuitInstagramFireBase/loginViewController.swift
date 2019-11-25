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
         label.font = UIFont(name: "Optima-BOld", size: 25)
         label.backgroundColor = .white
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    
    lazy var EmailTextField: UITextField = {
        let textField = UITextField()
        textField .translatesAutoresizingMaskIntoConstraints = false
        textField .placeholder = "Email"
        textField .borderStyle = .roundedRect
        textField .backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                //          textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
        //
    }()
    
    lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield .placeholder = "Password"
        textfield .borderStyle = .roundedRect
        textfield .backgroundColor = .white
        return textfield
    }()
    
    
         
      //MARK:   CONSTRAINTS
        private func setEmailTextFieldConstraints() {
             NSLayoutConstraint.activate([
                EmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                EmailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
                EmailTextField.widthAnchor.constraint(equalToConstant: 200),
                 EmailTextField.heightAnchor.constraint(equalToConstant: 35)
             ])
         }

    private func setPassWordTextFieldConstraints() {
        NSLayoutConstraint.activate ([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
    
    
    
    
    
    
     func setBrandLabel() {
    NSLayoutConstraint.activate([
             BrandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             BrandLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
             BrandLabel.widthAnchor.constraint(equalToConstant: 230),
             BrandLabel.heightAnchor.constraint(equalToConstant: 35)
         ])
     }
     

    //MARK: AddSubViews
    
    private func  addSubView() {
        self.view.addSubview(BrandLabel)
        self.view.addSubview(EmailTextField)
        self.view.addSubview(passwordTextField)

    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        setBrandLabel()
       setEmailTextFieldConstraints()
        setPassWordTextFieldConstraints()
        
        
    }


}


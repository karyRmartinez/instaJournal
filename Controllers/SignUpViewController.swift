//
//  PicsViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/22/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Create Account"
        label.font = UIFont(name: "Optima-BOld", size: 25)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
                textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: "Optima-BOld", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
                textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-BOld", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5)
        button.frame = CGRect(x: 150, y: 100, width: 30, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        
                button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        setupHeaderLabel()
        setupCreateStackView()
    }
    
    //    MARK: Obj-C Methods
    
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            createButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 0.5)
            createButton.isEnabled = false
            return
        }
        createButton.isEnabled = true
        createButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 1)
    }
    
    @objc func trySignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", and: "Please fill out all fields.")
            return
        }
        
        guard email.isValidEmail else {
            showAlert(with: "Error", and: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
            self?.handleCreateAccountResponse(with: result)
        }
    }
    
    //MARK: Private methods
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                    self?.handleCreatedUserInFirestore(result: newResult)
                }
            case .failure(let error):
                self?.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
            }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<(), Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    
                    return
            }

                        //MARK: TODO - refactor this logic into scene delegate
                        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                            if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                                window.rootViewController = loginViewController()
                            } else {
                                window.rootViewController = {
                                    let profileSetupVC = ProfileViewController()
                                    profileSetupVC.settingFromLogin = true
                                    return profileSetupVC
                                }()
                            }
                        }, completion: nil)
                    case .failure(let error):
                        self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
                    }
                }
            
            //MARK: UI Setup
            
            private func setupHeaderLabel() {
                view.addSubview(headerLabel)
                
                headerLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
                    headerLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                    headerLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                    headerLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)])
            }
            
            private func setupCreateStackView() {
                let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,createButton])
                stackView.axis = .vertical
                stackView.spacing = 15
                stackView.distribution = .fillEqually
                self.view.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 100),
                    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
            }
}

//MARK: --TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
}

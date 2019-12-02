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
         label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
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
      textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
        //
    }()
    
    lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield .placeholder = "Password"
        textfield .borderStyle = .roundedRect
         textfield.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        textfield .backgroundColor = .white
        return textfield
    }()
    
    
    lazy var LogInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.5880904794, green: 0.3762845993, blue: 1, alpha: 0.6412760417)
        button.frame = CGRect(x: 150, y: 100, width: 20, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("Loggin", for: .normal)
          button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)

        return button
    }()
    
    lazy var SignUPButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.5880904794, green: 0.3762845993, blue: 1, alpha: 0.6412760417)
        button.frame = CGRect(x: 150, y: 100, width: 20, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("Sign up", for: .normal)

        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        
        
        return button
        
        
    }()
     
    @objc func showSignUp() {
        let signupVC = SignUpViewController()
        signupVC.modalPresentationStyle = .formSheet
        present(signupVC, animated: true, completion: nil)
    }
    
    
    
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
    
    
    private func setLogInButton() {
        NSLayoutConstraint.activate([
            LogInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LogInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 90),
            LogInButton.widthAnchor.constraint(equalToConstant: 90),
            LogInButton.heightAnchor.constraint(equalToConstant: 30)
            
            
        ])
    }
    
    private func setSignUp() {
        NSLayoutConstraint.activate ([
            SignUPButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SignUPButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            SignUPButton.widthAnchor.constraint(equalToConstant: 110),
            SignUPButton.heightAnchor.constraint(equalToConstant: 30)
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
     
    
//    @objc private func navigateScreen() {
//           self.navigationController?.pushViewController(ProfileViewController(), animated: true)
//       }
//
    
//
// @objc func continueButtonPressed(){
//        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
//       //TODO: transition to a controller where you can create ToDos
//   }
//  
      
      //MARK: Obj-C methods
      
      @objc func validateFields() {
          guard EmailTextField.hasText, passwordTextField.hasText else {
              LogInButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 0.5)
              LogInButton.isEnabled = false
              return
          }
          LogInButton.isEnabled = true
          LogInButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 1)
      }
      
    
    private func showAlert(with title: String, and message: String) {
         let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         present(alertVC, animated: true, completion: nil)
     }
    
    
    
    private func handleLoginResponse(with result: Result<(), Error>) {
           switch result {
           case .failure(let error):
               showAlert(with: "Error", and: "Could not log in. Error: \(error)")
           case .success:
               
               guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                   else {
                       //MARK: TODO - handle could not swap root view controller
                       return
               }
               
               //MARK: TODO - refactor this logic into scene delegate
               UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                   if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                       window.rootViewController = ProfileViewController()
                   } else {
                       window.rootViewController = {
                           let profileSetupVC = ProfileViewController()
                           profileSetupVC.settingFromLogin = true
                           return profileSetupVC
                       }()
                   }
               }, completion: nil)
           }
       }
    
    
 
    
    
      
      @objc func tryLogin() {
          guard let email = EmailTextField.text, let password = passwordTextField.text else {
              showAlert(with: "Error", and: "Please fill out all fields.")
              return
          }
          
          //MARK: TODO - remove whitespace (if any) from email/password
          
          guard email.isValidEmail else {
              showAlert(with: "Error", and: "Please enter a valid email")
              return
          }
          
          guard password.isValidPassword else {
              showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
              return
          }
          
          FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
              self.handleLoginResponse(with: result)
          }
      }
      
 
    
    
    //MARK: AddSubViews
    
    private func  addSubView() {
        self.view.addSubview(BrandLabel)
        self.view.addSubview(EmailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(LogInButton)
        self.view.addSubview(SignUPButton)
        

    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        setBrandLabel()
       setEmailTextFieldConstraints()
        setPassWordTextFieldConstraints()
        setLogInButton()
        setSignUp()
       
        
//
//          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(continueButtonPressed))
//
        
    }


}

//MARK: --TextField Delegate
extension loginViewController: UITextFieldDelegate {
    
}
  

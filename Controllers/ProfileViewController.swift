//
//  ProfileViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/25/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var displayNameHolder = "Display Name"
   var defaultImage = UIImage(systemName: "person")
      var settingFromLogin = false

    var imageSaved = UIImage() {
         didSet {
             profileImage.image = imageSaved
         }
     }
    var imageURL: URL? = nil
    
    
    //MARK: UI OBJ
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
          label.font = UIFont(name: "Optima-BOld", size: 55)
        label.text = "Profile"
        return label
    }()
    
    var profileImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = defaultImage 
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    lazy var userNameTextField: UITextField = {
         let textField = UITextField()
         textField.placeholder = "Enter User Name"
         textField.font = UIFont(name: "Verdana", size: 14)
         textField.backgroundColor = .white
         textField.borderStyle = .bezel
         textField.layer.cornerRadius = 5
         textField.autocorrectionType = .no
         return textField
     }()
    lazy var userNameLabel : UILabel = {
          let label = UILabel()
        label.textColor = .purple
          label.text = displayNameHolder
          label.font = UIFont(name: "Arial", size: 25.0)
          label.textAlignment = .center
          return label
      }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Image", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
     //   button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var saveButton: UIButton = {
          let button = UIButton()
          button.setTitle("Save", for: .normal)
        button.setTitleColor(.purple, for: .normal)
          button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = .white
//          button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
          return button
      }()
    
    lazy var editDisplayNameButton: UIButton = {
           let button = UIButton()
           button.setTitle("Edit Username", for: .normal)
           button.setTitleColor(.blue, for: .normal)
           button.addTarget(self, action: #selector(editDisplayNamePressed), for: .touchUpInside)
           return button
       }()
    @objc func editDisplayNamePressed() {
        let alert = UIAlertController(title: "UserName", message: nil, preferredStyle: .alert)
        
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter UserName"
        }
        
        guard let userNameField = alert.textFields else {return}
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (alert) -> Void in
            
            self.userNameLabel.text = userNameField[0].text ?? self.displayNameHolder
            self.formValidation()
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
  
   private func formValidation() {
       let validUserName = userNameLabel.text != displayNameHolder
       let imagePresent = profileImage.image != defaultImage
       saveButton.isEnabled = validUserName && imagePresent
   }
   
      private func loadImage() {
          guard let imageUrl = FirebaseAuthService.manager.currentUser?.photoURL else {
              print("photo url not found")
              return
          }
          ImageHelper.shared.getImage(urlStr: imageUrl.absoluteString) { (result) in
              switch result {
              case .failure(let error):
                  print(error)
              case .success(let imageFromUrl):
                  DispatchQueue.main.async {
                    self.imageSaved = imageFromUrl
                  }
                  
              }
          }
      }
      
      private func setupCaptureSession() {
          DispatchQueue.main.async {
              let myPickerController = UIImagePickerController()
              myPickerController.delegate = self
              myPickerController.sourceType = .photoLibrary
              myPickerController.allowsEditing = true
              myPickerController.mediaTypes = ["public.image"]
              self.present(myPickerController, animated: true, completion: nil)
          }
      }
      
      private func checkAuthorizationForAccessingPhotos() {
          switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
          case .authorized: // The user has previously granted access to the camera.
              return setupCaptureSession()
              
          case .notDetermined: // The user has not yet been asked for camera access.
              AVCaptureDevice.requestAccess(for: .video) { granted in
                  if granted {
                      self.setupCaptureSession()
                  }
              }
              
          case .denied: // The user has previously denied access.
              return alertCameraAccessNeeded()
              
          case .restricted: // The user can't grant access due to restrictions.
              return
              
          default:
              return
          }
      }
      
      private func alertCameraAccessNeeded() {
          let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
          
          let alert = UIAlertController(
              title: "Need Camera Access",
              message: "Camera access is required to make full use of this app.",
              preferredStyle: UIAlertController.Style.alert
          )
          
          alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
          alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
              UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
          }))
          present(alert, animated: true, completion: nil)
      }
    
      
        
      
      private func showErrorAlert(title: String, message: String) {
          let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
          present(alertVC, animated: true, completion: nil)
      }

    
@objc private func navigateScreen() {
self.navigationController?.pushViewController(FeedViewController(), animated: true)
}
    
        
    
     @objc func continueButtonPressed(){
            self.navigationController?.pushViewController(FeedViewController(), animated: true)
           //TODO: transition to a controller where you can create ToDos
       }
      
    
    
    private func setupHeaderLabel() {
   profileLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               profileLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
             profileLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
           profileLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
               profileLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)])
       }
       
    private func setImageConstraints() {
         profileImage.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             profileImage.centerXAnchor.constraint(equalTo: profileLabel.centerXAnchor),
             profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             profileImage.widthAnchor.constraint(equalToConstant: 200),
             profileImage.heightAnchor.constraint(equalToConstant: 200)])
     }
    
    private func setupAddImageButton() {
  addImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 500),
            addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addImageButton.heightAnchor.constraint(equalToConstant: 50),
            addImageButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3)
        ])
    }
    
    private func SaveButtonconstrains() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        saveButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 600),
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 saveButton.heightAnchor.constraint(equalToConstant: 50),
                 saveButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3)
             ])
    }
   private func setDisplayLabelConstraints() {
     userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 20),
            userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 200),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])


    }
    private func setEditDisplayButtonConstraints() {
  editDisplayNameButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      editDisplayNameButton.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 10),
       editDisplayNameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    editDisplayNameButton.widthAnchor.constraint(equalToConstant: 200),
    editDisplayNameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func addSubviews() {
        view.addSubview(profileLabel)
        view.addSubview(profileImage)
        view.addSubview(userNameTextField)
        view.addSubview(userNameLabel)
        view.addSubview(addImageButton)
        view.addSubview(saveButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupHeaderLabel()
        setImageConstraints()
        setupAddImageButton()
        SaveButtonconstrains()
        setDisplayLabelConstraints()
        setEditDisplayButtonConstraints()
        if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
            loadImage()
            userNameLabel.text = displayName
            let user = FirebaseAuthService.manager.currentUser
            imageURL = user?.photoURL
        }
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "feed", style: .plain, target: self, action: #selector(continueButtonPressed))
        

    }


}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            //MARK: TODO - handle couldn't get image :(
            return
        }
        self.imageSaved = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            //MARK: TODO - gracefully fail out without interrupting UX
            return
        }
        
        FirebaseStorageService.manager.storeImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                //Note - defer UI response, update user image url in auth and in firestore when save is pressed
                self?.imageURL = url
            case .failure(let error):
                //MARK: TODO - defer image not save alert, try again later. maybe make VC "dirty" to allow user to move on in nav stack
                print(error)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}


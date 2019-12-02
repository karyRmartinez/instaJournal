//
//  ProfileViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/25/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit
import Photos

class ProfileViewController: UIViewController {
    
    var settingFromLogin = false

    var image = UIImage() {
         didSet {
             self.profileImage.image = image
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
      let image = UIImageView()
  image.image = UIImage(systemName: "name")
      image.contentMode = .scaleAspectFill
    
      return image
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
    
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Image", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
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
    

    
    
    
    @objc private func addImagePressed() {
        //MARK: TODO - action sheet with multiple media options
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("Denied photo library permissions")
                default:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("No usable status")
                }
            })
        default:
            presentPhotoPickerController()
        }
    }
    
    
    
    private func presentPhotoPickerController() {
         DispatchQueue.main.async{
             let imagePickerViewController = UIImagePickerController()
             imagePickerViewController.delegate = self
             imagePickerViewController.sourceType = .photoLibrary
             imagePickerViewController.allowsEditing = true
             imagePickerViewController.mediaTypes = ["public.image"]
             self.present(imagePickerViewController, animated: true, completion: nil)
         }
     }

    
        @objc private func navigateScreen() {
               self.navigationController?.pushViewController(FeedViewController(), animated: true)
           }
    
        
    
     @objc func continueButtonPressed(){
            self.navigationController?.pushViewController(FeedViewController(), animated: true)
           //TODO: transition to a controller where you can create ToDos
       }
      
    
    
    private func setupHeaderLabel() {
           view.addSubview(profileLabel)
        view.addSubview(userNameTextField)
        view.addSubview(saveButton)
        
           
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               profileLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
             profileLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
           profileLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
               profileLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)])
       }
       
    private func setImageConstraints() {
         view.addSubview(profileImage)
         profileImage.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             profileImage.centerXAnchor.constraint(equalTo: profileLabel.centerXAnchor),
             profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             profileImage.widthAnchor.constraint(equalToConstant: 200),
             profileImage.heightAnchor.constraint(equalToConstant: 200)])
     }
    
    private func setupAddImageButton() {
        view.addSubview(addImageButton)
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 500),
            addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addImageButton.heightAnchor.constraint(equalToConstant: 50),
            addImageButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3)
        ])
    }
    
    private func SaveButtonconstrains() {
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        saveButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 600),
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 saveButton.heightAnchor.constraint(equalToConstant: 50),
                 saveButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3)
             ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderLabel()
        setImageConstraints()
        setupAddImageButton()
        SaveButtonconstrains()
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "feed", style: .plain, target: self, action: #selector(continueButtonPressed))
        

    }


}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            //MARK: TODO - handle couldn't get image :(
            return
        }
        self.image = image
        
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


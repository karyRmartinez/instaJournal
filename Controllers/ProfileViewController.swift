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

    var image = UIImage() {
         didSet {
             self.profileImage.image = image
         }
     }
    var imageURL: String? = nil
    
    
    //MARK: UI OBJ
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
          label.font = UIFont(name: "Optima-BOld", size: 25)
        label.text = "Profile"
        return label
    }()
    
  var profileImage: UIImageView = {
      let image = UIImageView()
      image.image = UIImage(named: "noImage")
    image.image = #imageLiteral(resourceName: <#T##String#>)
      image.contentMode = .scaleAspectFill
      return image
  }()
    
    
    var addButton: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(named: "add"), for: .normal)
//         button.addTarget(self, action: #selector(presentPhotoPickerController), for: .touchUpInside)
         return button
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
       
    private func setImageConstraints() {
         view.addSubview(profileImage)
         profileImage.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             profileImage.centerXAnchor.constraint(equalTo: profileLabel.centerXAnchor),
             profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
             profileImage.widthAnchor.constraint(equalToConstant: 200),
             profileImage.heightAnchor.constraint(equalToConstant: 200)])
     }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderLabel()
        setImageConstraints()

    }


}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
    }
}

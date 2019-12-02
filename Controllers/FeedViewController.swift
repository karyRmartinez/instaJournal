//
//  FeedViewController.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 11/25/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    

  
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cv)
        cv.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        cv.dataSource = self
//        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    
      lazy var addButton: UIBarButtonItem = {
          let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
          return button
      }()
      
    
//    var posts = [Post]() {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    
//    private func loadPosts() {
//        FirestoreService.manager.getAllPost { (result) in
//            switch result {
//
//            case .success(let postsData):
//                self.posts = postsData
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    @objc private func addButtonPressed () {
        let profileVC = ProfileViewController()
        profileVC.navigationItem.title = "Upload Image"
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = addButton
        setConstraints()
    }
}

extension FeedViewController {
    private func setConstraints() {
        setCollectionViewConstraints()
    }
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}
//
//extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return posts.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
//        let imageData = posts[indexPath.row]
//
//        DispatchQueue.main.async {
//            FirebaseStorageService.uploadManager.getImage(url: imageData.imageUrl!) { (result) in
//                switch result {
//
//                case .success(let imageFromFirebase):
//                    cell.imageView.image = imageFromFirebase
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = DetailViewController()
//        let selectedPost = posts[indexPath.row]
//        detailVC.currentPost = selectedPost
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    


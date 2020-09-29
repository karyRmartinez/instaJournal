//
//  ImageHelper.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 9/28/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    // MARK: - Static Properties
    
    static let shared = ImageHelper()
    
    // MARK: - Instance Methods
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
        
        guard let url = URL(string: urlStr) else {
                   completionHandler(.failure(.badURL))
                   return
               }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            
            completionHandler(.success(image))
        }.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private init() {}
}

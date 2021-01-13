//
//  PhotoStore.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/8/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import UIKit

class PhotoStore {
    
    let imageStore = ImageStore()
    
    enum PhotoError: Error {
        case imageCreationError
        case missingImageURL
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
//            if let jsonData = data {
//                if let jsonString = String(data: jsonData,
//                                           encoding: .utf8) {
//                    print(jsonString)
//                } else if let requestError = error {
//                    print("Error fetching interesting photos: \(requestError)")
//                } else {
//                    print("Unexpected error with the request")
//                }
//            }
            let result = self.processPhotosRequest(data: data, error: error)
            // Using operation queues to call the completion closure on main thread
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?,
                                      error: Error?) -> Result<[Photo], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let photoKey = photo.photoID
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
          guard let photoURL = photo.remoteURL else {
              completion(.failure(PhotoError.missingImageURL))
              return
          }
          let request = URLRequest(url: photoURL)
          
          let task = session.dataTask(with: request) {
              (data,response,error) in
              
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
          }
          task.resume()
      }
    
    private func processImageRequest(data:Data?,
                                     error: Error?) -> Result<UIImage, Error> {
        guard
        let imageData = data,
            let image = UIImage(data: imageData) else {
                
                //Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
    
    
}
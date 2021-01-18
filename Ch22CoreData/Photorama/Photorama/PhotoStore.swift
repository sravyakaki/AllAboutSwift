//
//  PhotoStore.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/8/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import UIKit
import CoreData

class PhotoStore {
    
    let imageStore = ImageStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error))")
            }
            
        }
        return container
    } ()
    
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
            var result = self.processPhotosRequest(data: data, error: error)
            if case .success = result {
                do {
                    try self.persistentContainer.viewContext.save()
                } catch {
                    result = .failure(error)
                }
            }
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
        
        let context = persistentContainer.viewContext
        
        switch FlickrAPI.photos(fromJSON: jsonData) {
        case let .success(flickrPhotos):
            let photos = flickrPhotos.map { flickrPhoto -> Photo in
                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
                let predicate = NSPredicate(
                    format: "\(#keyPath(Photo.photoID)) == \(flickrPhoto.photoID)"
                )
                fetchRequest.predicate = predicate
                var fetchedPhotos: [Photo]?
                context.performAndWait {
                   fetchedPhotos = try? fetchRequest.execute()
            }
            if let existingPhoto = fetchedPhotos?.first {
                return existingPhoto
            }
                var photo: Photo!
                context.performAndWait {
                    photo = Photo(context: context)
                    photo.title = flickrPhoto.title
                    photo.photoID = flickrPhoto.photoID
                    photo.remoteURL = flickrPhoto.remoteURL
                    photo.dateTaken = flickrPhoto.dateTaken
                }
                return photo
            }
            return .success(photos)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID.")
        }
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
    
    func fetchAllPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortByDateTaken = NSSortDescriptor(key: #keyPath(Photo.dateTaken),
        ascending : true)
        fetchRequest.sortDescriptors = [sortByDateTaken]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
        do {
        let allPhotos = try viewContext.fetch(fetchRequest)
        completion(.success(allPhotos))
        } catch {
        completion(.failure(error))
        }
        }
    }
}

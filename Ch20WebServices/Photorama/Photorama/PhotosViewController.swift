//
//  ViewController.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/7/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    // Below we are using property injection to give photo store to the view controller
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos) :
                print("Successfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) in
            
            switch imageResult {
                // let is being used in case to declare image constant
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }


}


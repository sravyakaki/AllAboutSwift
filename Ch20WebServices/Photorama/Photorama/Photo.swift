//
//  Photo.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/8/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import Foundation

class Photo: Codable {
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/8/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import Foundation

// Creating an enum, flexible to add more endpoints in future. For now, we are just dealing with interesting photos endpoint.
enum EndPoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88"
    
    private static func flickrURL(endpoint: EndPoint, parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": endpoint.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for(key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
    
    //Computed Property
    static var interestingPhotosURL: URL {
        return flickrURL(endpoint: .interestingPhotos, parameters: ["extras": "url_z,date_taken"])
    }
    
    static func photos(fromJSON data: Data) -> Result<[FlickrPhoto], Error> {
        do {
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)

            let photos = flickrResponse.photosInfo.photos.filter { $0.remoteURL != nil }
            return .success(photos)
            
        } catch {
            return .failure(error)
        }
    }
    
}

struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [FlickrPhoto]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

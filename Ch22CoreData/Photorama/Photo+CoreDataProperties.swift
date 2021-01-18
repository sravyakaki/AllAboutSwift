//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/18/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var remoteURL: URL?

}

//
//  TagDataSource.swift
//  Photorama
//
//  Created by Sravya Kaki on 1/18/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import UIKit
import CoreData

class TagDataSource: NSObject, UITableViewDataSource {
    
    var tags = [Tag]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag.name
        
        cell.accessibilityHint = "Toggles Selection"
        cell.accessibilityTraits = [.button]
        
        return cell
    }
}
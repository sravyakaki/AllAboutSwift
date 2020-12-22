//
//  ItemStore.swift
//  LootLogger
//
//  Created by Sravya Kaki on 11/22/20.
//  Copyright © 2020 Sravya Kaki. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    //Creating this func as discardable so that we can call the func, but ignore the result.
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
        allItems.remove(at: index)
    }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
        
        
    }
    
}

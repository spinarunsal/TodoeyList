//
//  Item.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-10-21.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    //inverse relationship
    /*each item has a parentCategory that's of type category comes from property called items */
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}

//
//  Category.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-10-21.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    //forward relationship
    //each categry having a list of items
    let items = List<Item> ()
}

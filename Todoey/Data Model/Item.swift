//
//  Item.swift
//  Todoey
//
//  Created by Kahwai Lee on 7/2/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    @objc dynamic var dataCreated:Date?

    var parentCategory=LinkingObjects(fromType: Category.self, property: "items")   // 1 to many relationship to category
    
}

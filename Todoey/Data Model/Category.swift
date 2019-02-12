//
//  Category.swift
//  Todoey
//
//  Created by Kahwai Lee on 7/2/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String=""
    let items=List<Item>()  // ==  single relationship to items
    //var array=[Item]()
    
}

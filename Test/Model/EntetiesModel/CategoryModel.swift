//
//  CategoryModel.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class CategoryModel {
    static let model = ModelFirebase.model.ref.child("categories")
    
    private init(){}
    
    static func addCategory() -> () {
        model.child("1").setValue("Category 1")
    }
}

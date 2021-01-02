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
    static let model = ModelFirebase.instance.ref.child("categories")
    
    private init(){}
    
    static func addCategory(category: [String:String]) -> () {
        model.child(category["id"]!).setValue(category)
    }
    
    static func getAllCategories(callback: @escaping ([Category]?)->Void){
        let ref = CategoryModel.model

        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var data = [Category]();
                
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let category = Category(json: postDict)
                        data.append(category)
                    } else {
                        print("failed to convert")
                    }
                }
                
                callback(data)
            }
        })
    }
    
}

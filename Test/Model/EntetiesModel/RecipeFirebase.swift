//
//  RecipeFirebase.swift
//  Dulce
//
//  Created by admin on 02/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class RecipeFirebase {
    let model = ModelFirebase.model.ref.child("recipes")

    func getAllRecipesFB(since:Int64, callback: @escaping ([Recipe]?)->Void){
        model.queryOrdered(byChild: "lastUpdate").queryStarting(atValue: [Timestamp(seconds: since, nanoseconds: 0)])
            .observe(.value, with:{ (snapshot: DataSnapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var data = [Recipe]();
                
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let recipe = Recipe(json: postDict)
                        data.append(recipe)
                    } else {
                        print("failed to convert")
                    }
                }
                
                callback(data)
            }
        })
    }
}

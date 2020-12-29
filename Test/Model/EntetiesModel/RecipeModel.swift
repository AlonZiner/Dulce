//
//  RecipeModel.swift
//  Dulce
//
//  Created by Alon Zinar on 16/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class RecipeModel {
    static let model = ModelFirebase.model.ref.child("recipes")
    
    private init(){}
    
    static func addRecipe(recipe: [String:String]) -> () {
        model.child(recipe["id"]!).setValue(recipe)
    }
    
    static func getAllRecipes(callback: @escaping ([Recipe]?)->Void){
        let ref = RecipeModel.model

        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            
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

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

class Recipemodel {
    static let model = ModelFirebase.model.ref.child("recipes")
    
    static func addRecipe() -> () {
        model.child("3").setValue("pizza pizza")
    }
}

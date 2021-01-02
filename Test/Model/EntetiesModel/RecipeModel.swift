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
    let modelFirebase = ModelFirebase.instance
    let modelSql = ModelSql2()
    
    init(){
        modelSql.connect()
    }
    
    func addRecipe(recipe: Recipe) -> () {
        let json = recipe.toJson()
        modelFirebase.ref.child("recipes").child(json["id"]! as! String).setValue(json)
        
        //modelSql.add(recipe: recipe)
    }
    
    func getAllRecipesSql(callback: @escaping ([Recipe]?)->Void){
        //get the local last update date
        let lud = modelSql.getLastUpdateDate(name: "RECIPES");
        
        //get the cloud updates since the local update date
        modelFirebase.getAllRecipesFB(since:lud) { (data) in
            //insert update to the local db
            var lud:Int64 = 0;
            for student in data!{
                self.modelSql.add(recipe: student)
                
                if student.lastUpdate != nil && student.lastUpdate! > lud {
                    lud = student.lastUpdate!
                }
            }
            
            //update the students local last update date
            self.modelSql.setLastUpdate(name: "RECIPES", lastUpdated: lud)
            // get the complete student list
            let finalData = self.modelSql.getAllRecipes()
            callback(finalData);
        }
        
        
        callback(modelSql.getAllRecipes())
    }
}

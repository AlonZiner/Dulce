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
    let modelFirebase = ModelFirebase()
    let modelSql = ModelSql2.instance
    
    static let instance = RecipeModel()
        
    private init(){}
    
    func addRecipe(recipe: Recipe) -> () {
        let json = recipe.toJson()
        self.modelFirebase.ref.child("recipes").child(json["id"]! as! String).setValue(json)
    }
    
    func getAllRecipesSql(callback: @escaping ([Recipe]?)->Void){
        //get the local last update date
        var lud = self.modelSql.getLastUpdateDate(name: "RECIPES");
        let oldLud = lud
        
        //get the cloud updates since the local update date
        self.modelFirebase.getAllRecipesFB(since:lud) { (data) in
            //insert update to the local db
            for recipe in data!{
                self.modelSql.addRecipe(recipe: recipe)
                
                if recipe.lastUpdate != nil && recipe.lastUpdate! > lud {
                    lud = recipe.lastUpdate!
                }
            }
            
            if (lud > oldLud){
                //update the students local last update date
                self.modelSql.setLastUpdate(name: "RECIPES", lastUpdated: lud)
            }
            
            // get the complete student list
            let finalData = self.modelSql.getAllRecipes()
            callback(finalData);
        }
    }
    
    func getCategoryRecipesSql(categoryId:String, callback: @escaping ([Recipe]?)->Void){
        //get the local last update date
        var lud = self.modelSql.getLastUpdateDate(name: "RECIPES");
        let oldLud = lud
        
        //get the cloud updates since the local update date
        modelFirebase.getCategoryRecipesFB(since:lud, categoryId: categoryId) { (data) in
            //insert update to the local db
            for recipe in data!{
                self.modelSql.addRecipe(recipe: recipe)
                
                if recipe.lastUpdate != nil && recipe.lastUpdate! > lud {
                    lud = recipe.lastUpdate!
                }
            }
            
            if (lud > oldLud){
                //update the students local last update date
                self.modelSql.setLastUpdate(name: "RECIPES", lastUpdated: lud)
            }
            
            // get the complete student list
            let finalData = self.modelSql.getCategoryRecipes(categoryId: categoryId)
            callback(finalData);
        }
    }
}

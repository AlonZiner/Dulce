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
    let modelFirebase = ModelFirebase.instance
    let modelSql = ModelSql2()
    
    public init(){
        modelSql.connect()
    }
    
    func addCategory(category: Category) -> () {
        let json = category.toJson()
        modelFirebase.ref.child("categories").child(json["id"] as! String).setValue(json)
    }
    
    func getAllCategories(callback: @escaping ([Category]?)->Void){
       //get the local last update date
        let lud = modelSql.getLastUpdateDate(name: "CATEGORIES");
        
        //get the cloud updates since the local update date
        modelFirebase.getAllCategoriesFB(since:lud) { (data) in
            //insert update to the local db
            var lud:Int64 = 0;
            for category in data!{
                self.modelSql.addCategory(category: category)
                
                if category.lastUpdate != nil && category.lastUpdate! > lud {
                    lud = category.lastUpdate!
                }
            }
            
            //update the students local last update date
            self.modelSql.setLastUpdate(name: "CATEGORIES", lastUpdated: lud)
            // get the complete student list
            let finalData = self.modelSql.getAllCategories()
            callback(finalData);
        }
    }
    
}

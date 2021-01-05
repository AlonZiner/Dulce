//
//  ModelFirebase.swift
//  Dulce
//
//  Created by Alon Zinar on 16/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ModelFirebase {
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database(url: "https://dulce-acbaa-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
    func getAllRecipesFB(since:Int64, callback: @escaping ([Recipe]?)->Void){
        ref.child("recipes")
            .queryOrdered(byChild: "lastUpdate").queryStarting(atValue: since + 1)
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
    
    func getCategoryRecipesFB(since:Int64, categoryId:String, callback: @escaping ([Recipe]?)->Void){
        ref.child("recipes")
            .queryOrdered(byChild: "lastUpdate").queryStarting(atValue: since + 1)
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
                
                let categoryData = data.filter{recipe in return recipe.CategoryId == categoryId}
                callback(categoryData)
            }
        })
    }
    
    
    func getAllCategoriesFB(since:Int64, callback: @escaping ([Category]?)->Void){
        ref.child("categories")
            .queryOrdered(byChild: "lastUpdate").queryStarting(atValue: since + 1)
            .observe(.value, with:{ (snapshot: DataSnapshot) in
            
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
    
    func getUser(since:Int64, uid:String, callback: @escaping (User?)->Void){
        ref.child("users")
            .queryOrdered(byChild: "lastUpdate").queryStarting(atValue: since + 1)
            .observe(.value, with:{ (snapshot: DataSnapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var data = [User]();
                
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let user = User(json: postDict)
                        data.append(user)
                    } else {
                        print("failed to convert")
                    }
                }
                
                let user = data.filter{u in return u.Id == uid}.first
                callback(user)
            }
        })
    }
    
    func saveImage(image:UIImage, imageName:String, callback:@escaping (String)->Void) {
        FirebaseStorage.saveImage(image: image, imageName: imageName, callback: callback)
    }
}

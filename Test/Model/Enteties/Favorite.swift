//
//  Favorite.swift
//  Dulce
//
//  Created by admin on 06/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation
import Firebase

class Favorite: NSObject {
    var Id: String
    var UserId: String
    var RecipeId: String
    var lastUpdate: Int64?

    // recipe ids array for Favorites
    
    init(Id: String, userId: String, recipeId: String) {
        self.Id = Id
        self.UserId = userId
        self.RecipeId = recipeId
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String
        UserId = json["userId"] as! String
        RecipeId = json["recipeId"] as! String
        lastUpdate = json["lastUpdate"] as? Int64
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = Id
        json["userId"] = UserId
        json["recipeId"] = RecipeId
        json["lastUpdate"] = ServerValue.timestamp()

        return json;
    }
}

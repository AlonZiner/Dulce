//
//  Recipe.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase

class Recipe {
    var Id: String
    var Title: String
    var Difficulty: Int
    var TimeToMake: Int
    var Publisher: String // user id
    var Instructions: String
    var lastUpdate: Int64?
    // comments array
    
    init(Title: String, Difficulty: Int, TimeToMake: Int, Publisher: String, Instructions: String) {
        self.Id = UUID().uuidString
        self.Title = Title
        self.Difficulty = Difficulty
        self.TimeToMake = TimeToMake
        self.Publisher = Publisher
        self.Instructions = Instructions
    }
    
    init(Id: String,Title: String, Difficulty: Int, TimeToMake: Int, Publisher: String, Instructions: String) {
        self.Id = Id
        self.Title = Title
        self.Difficulty = Difficulty
        self.TimeToMake = TimeToMake
        self.Publisher = Publisher
        self.Instructions = Instructions
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String
        Title = json["title"] as! String
        Difficulty = Int(json["difficulty"] as! String) ?? 0
        TimeToMake = Int(json["timeToMake"] as! String) ?? 0
        Publisher = json["publisher"] as! String
        Instructions = json["instructions"] as! String
        lastUpdate = json["lastUpdate"] as! Int64
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = Id
        json["title"] = Title
        json["difficulty"] = Difficulty.description
        json["timeToMake"] = TimeToMake.description
        json["publisher"] = Publisher
        json["instructions"] = Instructions
        json["lastUpdate"] = ServerValue.timestamp()
        
        return json;
    }
}

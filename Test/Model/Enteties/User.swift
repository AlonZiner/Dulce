//
//  User.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    var Id: String
    var Name: String
    var Picture: String
    var lastUpdate: Int64?

    // recipe ids array for Favorites
    
    init(Id: String, name: String, Picture: String) {
        self.Id = Id
        self.Name = name
        self.Picture = Picture
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String
        Name = json["name"] as! String
        Picture = json["picture"] as! String
        lastUpdate = json["lastUpdate"] as? Int64
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = Id
        json["name"] = Name
        json["picture"] = Picture
        json["lastUpdate"] = ServerValue.timestamp()

        return json;
    }
    
}

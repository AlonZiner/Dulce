//
//  Category.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase

class Category {
    var Id: String;
    var Name: String?;
    var lastUpdate: Int64?

    init(id: String, name: String) {
        Id = id
        Name = name
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String
        Name = json["name"] as! String?
        lastUpdate = json["lastUpdate"] as? Int64
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = Id
        json["name"] = Name
        json["lastUpdate"] = ServerValue.timestamp()

        return json;
    }
}

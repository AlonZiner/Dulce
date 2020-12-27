//
//  Category.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation

class Category {
    var Id: String;
    var Name: String?;
    
    init(name: String) {
        Id = UUID().uuidString
        Name = name
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String
        Name = json["name"] as! String?
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = Id
        json["name"] = Name
        return json;
    }
}

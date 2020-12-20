//
//  User.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation

class User: NSObject {
    var Id: String?
    var Name: String?
    var Email: String? // keep it if email can be obtained by firebase auth
    var Picture: String?
    // recipe ids array for Favorites
    
    init(Id: String, name: String?, EMail: String?, Picture: String?) {
        self.Id = Id
        self.Name = name
        self.Email = EMail
        self.Picture = Picture
    }
    
    init(json:[String:Any]){
        Id = json["id"] as! String?
        Name = json["name"] as! String?
        Email = json["email"] as! String?
        Picture = json["picture"] as! String?
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = Id
        json["name"] = Name
        json["picture"] = Picture
        return json;
    }
    
}

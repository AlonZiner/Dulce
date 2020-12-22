//
//  UserModel.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class UserModel {
    static let model = ModelFirebase.model.ref.child("users")
    
    private init(){}
    
    static func addUser(user: [String:String]) -> () {
        model.child(user["id"]!).setValue(user)
    }
    
    static func getAllStudents(callback: @escaping ([User]?)->Void){
        let ref = UserModel.model

        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            
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
                
                callback(data)
            }
        })
    }
}

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
    let modelFirebase = ModelFirebase.instance
    let modelSql = ModelSql2()
    
    init(){
        modelSql.connect()
    }
    
    func addUser(user: User) -> () {
        modelFirebase.ref.child("users").child(user.Id).setValue(user.toJson())
    }
    
    func getUser(uid:String, callback: @escaping (User?)->Void){
        //get the local last update date
        var lud = modelSql.getLastUpdateDate(name: "USERS");
        let oldLud = lud
        
        //get the cloud updates since the local update date
        modelFirebase.getUser(since:lud, uid: uid) { (user) in
            //insert update to the local db
            
            if (user != nil){
                self.modelSql.addUser(user: user!)
                
                if user!.lastUpdate != nil && user!.lastUpdate! > lud {
                    lud = user!.lastUpdate!
                }
                
                if (lud > oldLud){
                    //update the students local last update date
                    self.modelSql.setLastUpdate(name: "USERS", lastUpdated: lud)
                }
            }
            
            // get the complete student list
            let finalData = self.modelSql.getUserbyId(uid: uid)
            callback(finalData);
        }
    }
}

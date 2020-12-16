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
    static let model = ModelFirebase()

    private init() {
        ref = Database.database(url: "https://dulce-acbaa-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
    func addRecepie() -> () {
        self.ref.child("recepies").child("2").setValue("pizza bulgarit")
    }
}

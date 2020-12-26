//
//  FavoritesViewController.swift
//  Dulce
//
//  Created by admin on 11/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // example for using authinticated user data in app
        if let user = Auth.auth().currentUser {
            userName.text = user.displayName ?? ""
        }
    }
    
    
    @IBAction func addToDb(_ sender: Any) {
        RecipeModel.addRecipe()
    }
    
    @IBAction func getUsers(_ sender: Any) {
        UserModel.getAllStudents{ (_data:[User]?) in
            if (_data != nil) {
                // do somthing with the data
            }
        };
    }
    
    @IBAction func AddUserSql(_ sender: Any) {
        let model = ModelSql()
        //model.AddUser()
    }
    
    @IBAction func GetUserSql(_ sender: Any) {
        let model = ModelSql()
        let users = model.GetAllUsers()
        
    }
}

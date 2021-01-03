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
    
    @IBAction func getRecipe(_ sender: Any) {
        //let model = RecipeModel()
        let model = ModelSql2()
        model.connect()
        model.drop()
    }
}

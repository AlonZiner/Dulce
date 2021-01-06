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
    var userFavorites:[Favorite] = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData() {
        if let user = Auth.auth().currentUser {
          userName.text = user.displayName ?? ""
               
            FavoriteModel.instance.getUserFavorites(userId: user.uid){ (data) in
                // put data in tableview data souce
                // change controller to table view controller
            }
        }
    }
    
    @IBAction func getRecipe(_ sender: Any) {
        ModelSql2.instance.drop()
    }
}

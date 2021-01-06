//
//  FavoritesTableViewController.swift
//  Dulce
//
//  Created by Yoni Hodeffi on 06/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class FavoritesTableViewController: UITableViewController {
    

    var favorites:[Favorite] = [Favorite]()
    let recipy = Recipe(Id: "string", Title: "Cake", Difficulty: 2, TimeToMake: 4, Publisher: "string", Instructions: "instructions", Picture: "picture", CategoryId: "category");
    
    var recipes: [Recipe] = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipes.append(self.recipy)
        
        // go to db get data from favorites
        
        // find appropriate recipes
        
        reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.Title
        cell.detailTextLabel?.text = "🕑 \(recipe.TimeToMake) minutes"
        
        let url = URL(string: recipe.Picture)
        if (url != nil)
        {
            cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: "logo1"), options: nil, progressBlock: nil, completionHandler: { imageResult, error, type, cache in
              cell.imageView?.image = imageResult
            })
        }
        
        return cell
    }
    
    func reloadData() {
        if let user = Auth.auth().currentUser {
            FavoriteModel.instance.getUserFavorites(userId: user.uid){ (data) in
                // put data in tableview data souce
                // change controller to table view controller
                self.favorites = data;
            }
        }
    }

}

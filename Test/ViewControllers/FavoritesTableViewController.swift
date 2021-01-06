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
    var recipes: [Recipe] = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // handle click on single cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // navigation on cell clicking
       
        // creating the new view controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        
        // setting new vc parameters
        resultViewController.recipe = recipes[indexPath.row]
        
        // pushing the new vc
        present(resultViewController, animated: true, completion: nil)
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
            FavoriteModel.instance.getUserFavorites(userId: user.uid){ (fav) in
                // put data in tableview data souce
                // change controller to table view controller
                
                self.favorites = fav
                self.loadRecipes()
            }
        }
    }
    
    
    func loadRecipes(){
        for f in favorites {
            RecipeModel.instance.getRecipebyId(recipeId: f.RecipeId){ (rec) in
                if (rec != nil){
                    self.recipes.append(rec!)
                    self.tableView.reloadData()
                }
            }
        }
    }

}

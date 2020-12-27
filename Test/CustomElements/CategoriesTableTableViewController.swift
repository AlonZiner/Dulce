//
//  CategoriesTableTableViewController.swift
//  Dulce
//
//  Created by admin on 13/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class CategoriesTableTableViewController: UITableViewController {
    
    @IBOutlet var categoriesTableView: UITableView!
    let categories = [
        RecipeCategory(id: "at", name: "Cookies"),
        RecipeCategory(id: "be", name: "Breads"),
        RecipeCategory(id: "de", name: "Sugarless"),
        RecipeCategory(id: "el", name: "Gluten Free"),
        RecipeCategory(id: "fr", name: "Cakes"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // navigation on cell clicking
       
        // creating the new view controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        
        // setting new vc parameters
        resultViewController.recipeName = indexPath.row.description + " " + categories[indexPath.row].name
        
        // pushing the new vc
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        // Configure the cell...
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "very tasty!!"
        cell.imageView?.image = UIImage(named: "cake")

        return cell
    }
    
    // TODO: move
    struct RecipeCategory {
        var id: String
        var name: String
    }
}

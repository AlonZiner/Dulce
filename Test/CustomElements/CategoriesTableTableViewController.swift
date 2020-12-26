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

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        self.navigationController?.pushViewController(ChatViewController(), animated: true)
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

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
    var categories: [Category] = []
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start indeicator
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        
        CategoryModel.getAllCategories{ (_data:[Category]?) in
            if (_data != nil) {
                // stop indicator
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                
                self.categories = _data ?? [Category]()
                self.tableView.reloadData()
            }
        }
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
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
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        
        // setting new vc parameters
        resultViewController.categoryName = indexPath.row.description + " " + (categories[indexPath.row].Name ?? "")
        
        // pushing the new vc
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.Name
        cell.detailTextLabel?.text = "very tasty!!"
        cell.imageView?.image = UIImage(named: "cake")
        return cell
    }
}

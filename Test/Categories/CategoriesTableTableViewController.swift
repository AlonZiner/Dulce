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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCategoryButton()
        
        self.refreshControl = UIRefreshControl();
        
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        
        reloadData()
    }
    
    @objc func reloadData(){
        let model = CategoryModel()
        model.getAllCategories { (_data:[Category]?) in
            if (_data != nil) {
                
                self.categories = _data ?? [Category]()
                self.tableView.reloadData()
            }
            
            self.refreshControl?.endRefreshing()
        }
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
        resultViewController.category = categories[indexPath.row]
        // pushing the new vc
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.Name
        cell.detailTextLabel?.text = "very tasty!!" // TODO: add category description?
        return cell
    }
    
    
    func addCategoryButton(){
        let resultButton = UIButton()
        let color = HexStringToUIColor.hexStringToUIColor(hex:"#7bafa5",alpha:0.6)
        resultButton.backgroundColor = color;
        resultButton.setTitle("Add Category", for: .normal)
        resultButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        tableView.addSubview(resultButton)
        
        // set position
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        resultButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        resultButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        resultButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        resultButton.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        resultButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view
    }
    
    @objc func buttonTapped(sender : UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        
        resultViewController.modalPresentationStyle = .overCurrentContext
        present(resultViewController, animated: true, completion: nil)
    }
    
}

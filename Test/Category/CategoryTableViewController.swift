//
//  CategoryTableViewController.swift
//  Dulce
//
//  Created by admin on 29/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewController: UITableViewController {

    var categoryName: String?
    var category: Category?
    var recipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRecipeButton()
        
        self.navigationItem.title = category?.Name ?? "Category"
        
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        
        reloadData()
    }
    
    @objc func reloadData(){
        let model = RecipeModel()
        model.getCategoryRecipesSql(categoryId: category?.Id ?? ""){ (_data:[Recipe]?) in
            if (_data != nil) {
                self.recipes = _data ?? [Recipe]()
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
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // navigation on cell clicking
       
        // creating the new view controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        
        // setting new vc parameters
        resultViewController.recipe = recipes[indexPath.row]
        
        // pushing the new vc
        self.navigationController?.pushViewController(resultViewController, animated: true)
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
    
    func addRecipeButton(){
        let resultButton = UIButton()
        let color = HexStringToUIColor.hexStringToUIColor(hex:"#7bafa5",alpha:0.6)
        resultButton.backgroundColor = color
        resultButton.setTitle("Add Recipe", for: .normal)
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
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        
        resultViewController.category = self.category
        resultViewController.modalPresentationStyle = .overCurrentContext
        present(resultViewController, animated: true, completion: nil)
    }
}

//
//  CategoriesEditViewController.swift
//  Dulce
//
//  Created by admin on 27/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class CategoriesEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func AddCategory(_ sender: Any) {
        
        // add category to db
        //let category = Category(id: UUID().uuidString, name: "BreakFast")
        //CategoryModel.addCategory(category: category.toJson())
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        
       
        resultViewController.modalPresentationStyle = .overCurrentContext
        // pushing the new vc
        present(resultViewController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(resultViewController, animated: true)
        
        // refresh table view data
        
    }
}

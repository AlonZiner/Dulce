//
//  AddCategoryViewController.swift
//  Dulce
//
//  Created by admin on 27/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet weak var newCategoryName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Add(_ sender: Any) {
        
        CategoryModel.addCategory(category: Category(name: newCategoryName.text!).toJson())
        
        dismiss(animated: true, completion: nil)
    }
}

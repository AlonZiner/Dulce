//
//  AddRecipeViewController.swift
//  Dulce
//
//  Created by admin on 29/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var RecipeInstructions: UITextView!
    @IBOutlet weak var recipeName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddRecipe(_ sender: Any) {
        // add recipe
        
        dismiss(animated: true, completion: nil)
    }
}
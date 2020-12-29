//
//  CategoryEditViewController.swift
//  Dulce
//
//  Created by admin on 29/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class CategoryEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddRecipe(_ sender: Any) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
     
    
     resultViewController.modalPresentationStyle = .overCurrentContext
     // pushing the new vc
     present(resultViewController, animated: true, completion: nil)
    
    }
}

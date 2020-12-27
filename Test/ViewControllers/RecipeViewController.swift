//
//  RecipeViewController.swift
//  Dulce
//
//  Created by admin on 27/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    var recipeName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(recipeName ?? "")
    }

}

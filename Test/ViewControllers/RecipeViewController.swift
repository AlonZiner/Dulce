//
//  RecipeViewController.swift
//  Dulce
//
//  Created by admin on 27/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    var recipe:Recipe?
        
    @IBOutlet weak var difficualtyLabel: UILabel!
    @IBOutlet weak var timetoMakeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = recipe?.Title
        difficualtyLabel.text = recipe?.Difficulty.description
        timetoMakeLabel.text = recipe?.TimeToMake.description
        instructionsTextView.text = recipe?.Instructions
    }

}

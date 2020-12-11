//
//  CustomTabBarControllerViewController.swift
//  Test
//
//  Created by admin on 11/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class CustomTabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setText()
    }
    
    @objc func setText() {
        
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Favorites"
        tabBar.items?[2].title = "Chat"
        tabBar.items?[3].title = "Friends"
        tabBar.items?[4].title = "Profile"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

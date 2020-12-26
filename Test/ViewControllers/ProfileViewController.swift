//
//  ProfileViewController.swift
//  Dulce
//
//  Created by admin on 11/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: try get user profile picture, if not exists show default picture
        
        //profileImage.image = UIImage(named: "cake")
        
        if let user = Auth.auth().currentUser {
            userName.text = user.displayName ?? "Profile"
            userEmail.text = user.email ?? ""
            
            let url = URL(string: user.photoURL!.absoluteString)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            profileImage.image = UIImage(data: data!)
        }
        
        
    }
    
    @IBAction func LogOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        
        // Sign out from Firebase
        do {
            try Auth.auth().signOut()
            
            // Update screen after user successfully signed out
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
            print("user successfully sign out")

        } catch let error as NSError {
            print ("Error signing out from Firebase: %@", error)
        }
    }
}

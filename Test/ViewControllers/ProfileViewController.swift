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
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    var uid:String = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firebaseUser = Auth.auth().currentUser {
            uid = firebaseUser.uid
        }
        
        reloadData()
    }
    
    func reloadData(){
        let model = UserModel()
        
        model.getUser(uid: self.uid){ (user:User?) in
            if (user != nil) {
                self.user = user
                self.userName.text = user?.Name ?? "Profile"
                self.userEmail.text = "remove email.."
                
                let url = URL(string: user?.Picture ?? "")
                self.profileImage.kf.setImage(with: url)
            }
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

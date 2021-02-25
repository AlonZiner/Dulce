//
//  LoginViewController.swift
//  Test
//
//  Created by admin on 11/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//
//What is this shit????
import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // Get credential object using Google ID token and Google access token
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        // Authenticate with Firebase using the credential object
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
            }
                
            // Post notification after user successfully sign in
                
            else{
                print("user successfully sign in")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

                let user = Auth.auth().currentUser!

                // if the user isnt exists - add it
                
                let newUser = User(Id: user.uid, name: user.displayName ?? "user", Picture: user.photoURL?.absoluteString ?? "")
                
                UserModel.instance.addUser(user: newUser)
                
                
                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        }
    }
}

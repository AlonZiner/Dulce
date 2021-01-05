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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
   
    let model = UserModel()
    var uid:String = ""
    var user: User?
    var selectedImage:UIImage?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firebaseUser = Auth.auth().currentUser {
            uid = firebaseUser.uid
        }
        
        reloadData()
    }
    
    func reloadData(){
        
        model.getUser(uid: self.uid){ (user:User?) in
            if (user != nil) {
                self.user = user
                self.userName.text = user?.Name ?? "Profile"
                
                let url = URL(string: user?.Picture ?? "")
                self.profileImage.kf.setImage(with: url)
            }
        }
        
//        var recipeModel = RecipeModel()
//        recipeModel.getUserRecipeCount()
        
    }
    
    @IBAction func EditProfilePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self;
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.profileImage.image = selectedImage;
        
        // save user
        let model = UserModel()
        
        model.modelFirebase.saveImage(image: selectedImage!, imageName: self.uid) { (url) in
            self.user?.Picture = url
            model.addUser(user: self.user!)
            self.navigationController?.popViewController(animated: true)
        }
        
        picker.dismiss(animated: true, completion: nil)
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

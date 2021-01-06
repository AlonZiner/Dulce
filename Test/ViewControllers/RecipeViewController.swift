//
//  RecipeViewController.swift
//  Dulce
//
//  Created by admin on 27/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class RecipeViewController: UIViewController {

    var recipe:Recipe?
        
    @IBOutlet weak var difficualtyLabel: UILabel!
    @IBOutlet weak var timetoMakeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var addToFavorites: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isCurrentUser = Auth.auth().currentUser?.uid == recipe?.Publisher
        
        deleteBtn.isHidden = (!isCurrentUser)
        editBtn.isHidden = (!isCurrentUser)
        
        titleLabel.text = recipe?.Title
        difficualtyLabel.text = recipe?.Difficulty.description
        timetoMakeLabel.text = recipe?.TimeToMake.description
        instructionsTextView.text = recipe?.Instructions
        publisherLabel.text = recipe?.Publisher // get user name by id
        picture.image = UIImage(named: "recipe")
        
        let url = URL(string: recipe?.Picture ?? "")
        if (url != nil)
        {
            picture.kf.setImage(with: url)
        }
        
        UserModel.instance.getUser(uid: recipe!.Publisher){ (user:User?) in
            if (user != nil) {
                self.publisherLabel.text = user?.Name ?? "Profile"
                
                //let url = URL(string: user?.Picture ?? "")
                //self.profileImage.kf.setImage(with: url)
            }
        }
        configureUI()
    }
    
    @IBAction func addToFavoritesAction(_ sender: Any) {
        addToFavorites.isSelected.toggle()
        
        if (addToFavorites.isSelected){
            
            let favorite = Favorite(Id: UUID().uuidString, userId: Auth.auth().currentUser!.uid, recipeId: recipe!.Id)
            FavoriteModel.instance.addfavorite(favorite: favorite){
                // callback..
            }
        }
    }
    
    @IBAction func edit(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        
        resultViewController.category = Category(id: "123", name: "sdfs")
        resultViewController.recipe = self.recipe
        resultViewController.recipeVc = self
        resultViewController.modalPresentationStyle = .overCurrentContext
        present(resultViewController, animated: true, completion: self.dismissView)
    }
    
    func configureUI() {
        let image = UIImage(systemName: "star")
        let imageFilled = UIImage(systemName: "star.fill")
        addToFavorites.setImage(image, for: .normal)
        addToFavorites.setImage(imageFilled, for: .selected)
    }
    
    @IBAction func deleteRecipe(_ sender: Any) {
        RecipeModel.instance.deleteRecipe(recipe: self.recipe!){
            self.dismissView()
        }
    }
    
    func dismissView(){
        self.navigationController?.popViewController(animated: true)
    }
}

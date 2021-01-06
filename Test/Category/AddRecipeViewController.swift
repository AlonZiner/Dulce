//
//  AddRecipeViewController.swift
//  Dulce
//
//  Created by admin on 29/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit
import Firebase

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var RecipeInstructions: UITextView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TTMSlider: UISlider!
    @IBOutlet weak var TTMValueLabel: UILabel!
    @IBOutlet weak var DifficultySlider: UISlider!
    @IBOutlet weak var difficultyValueLabel: UILabel!
    
    var recipe:Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: send id and reload recipe
        if(recipe != nil){
            recipeName.text = recipe!.Title
            RecipeInstructions.text = recipe!.Instructions
            
            let url = URL(string: recipe!.Picture)
            imageView.kf.setImage(with: url)

            TTMSlider.value = Float(recipe!.TimeToMake)
            DifficultySlider.value = Float(recipe!.Difficulty)
            category!.Id = recipe!.CategoryId
            
            difficultyValueLabel.text = String(DifficultySlider.value)
            TTMValueLabel.text = String(TTMSlider.value)
            
            RecipeInstructions.becomeFirstResponder()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddRecipe(_ sender: Any) {
        save()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPicture(_ sender: Any) {
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
    
    var selectedImage:UIImage?;
    var category: Category?
    
    func save() {
        let model = RecipeModel.instance
        let modelFB = ModelFirebase()
       
        var id = UUID().uuidString
        if (recipe != nil){
            id = recipe!.Id
        }
        
        let newRecipe = Recipe(Id: id,
                            Title: recipeName.text ?? "no title",
                            Difficulty: Int(DifficultySlider.value),
                            TimeToMake: Int(TTMSlider.value),
                            Publisher: Auth.auth().currentUser!.uid,
                            Instructions: RecipeInstructions.text ?? "no instructions",
                            Picture: "",
                            CategoryId: self.category?.Id ?? "")

        guard let selectedImage = selectedImage else {
            
            if (recipe != nil)
            {
                newRecipe.Picture = recipe!.Picture
            }
            
            model.addRecipe(recipe: newRecipe)
            self.navigationController?.popViewController(animated: true);
            return;
        }
        
        self.selectedImage = imageView.image
        
        modelFB.saveImage(image: selectedImage, imageName: newRecipe.Id) { (url) in
            newRecipe.Picture = url
            model.addRecipe(recipe: newRecipe)
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.imageView.image = selectedImage;
        picker.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func TTMSliderChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        TTMValueLabel.text = "\(currentValue)"
    }
    
    @IBAction func DifficultySliderChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        difficultyValueLabel.text = "\(currentValue)"
    }
    
    var recipeVc: RecipeViewController?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            // TODO: Do your stuff here.
            if (self.recipeVc != nil){
                self.recipeVc!.dismissView()
            }
        }
    }
    
}

//
//  AddRecipeViewController.swift
//  Dulce
//
//  Created by admin on 29/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var RecipeInstructions: UITextView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func save() {
        let model = RecipeModel()
        let modelFB = ModelFirebase.instance
       
        let recipe = Recipe(Title: recipeName.text ?? "no title", Difficulty: 1, TimeToMake: 15, Publisher: "UserIdHere", Instructions: RecipeInstructions.text ?? "no instructions", Picture: "", CategoryId: "categoryIdHere")

        guard let selectedImage = selectedImage else {
            model.addRecipe(recipe: recipe)
            self.navigationController?.popViewController(animated: true);
            return;
        }
        
        self.selectedImage = nil
        
        modelFB.saveImage(image: selectedImage, imageName: recipe.Id) { (url) in
            recipe.Picture = url
            model.addRecipe(recipe: recipe)
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.imageView.image = selectedImage;
        picker.dismiss(animated: true, completion: nil);
    }
}

//
//  Recipe.swift
//  Dulce
//
//  Created by admin on 18/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation

class Recipe {
    var Id: String
    var Title: String
    var Difficulty: Int
    var TimeToMake: Int
    var Publisher: String // user id
    var Instructions: String
    // comments array
    
    init(Id: String, Title: String, Difficulty: Int, TimeToMake: Int, Publisher: String, Instructions: String) {
        self.Id = Id
        self.Title = Title
        self.Difficulty = Difficulty
        self.TimeToMake = TimeToMake
        self.Publisher = Publisher
        self.Instructions = Instructions
    }
}

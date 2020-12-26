//
//  LocalModel.swift
//  Dulce
//
//  Created by Alon Zinar on 16/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
import CoreData

// TODO: add local db with sqlite here
// the library and the bridging header already exists
class ModelSql {
    init() {
        
    }
    
    func AddUser(user: User) -> () {
        
        let dataController = DataController()
        let managedContext = dataController.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(user.Name, forKeyPath: "name")
        person.setValue(user.Id, forKeyPath: "id")
        person.setValue(user.Email, forKeyPath: "email")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func GetAllUsers() -> ([User]) {
        let dataController = DataController()
        let managedContext = dataController.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        // query specific
        //fetchRequest.predicate = NSPredicate(format: "name == %@", "eliav4")
        
        var NSUsers:[NSManagedObject]
        var users = [User]()
        
        do {
            NSUsers = try managedContext.fetch(fetchRequest)
            
            for u in NSUsers{
                print("st name = \(String(describing: u.value(forKey: "name")! ))")
                
                users.append(
                    User(Id: u.value(forKey: "id") as! String,
                         name: u.value(forKey: "name") as? String,
                         EMail: u.value(forKey: "email") as? String,
                         Picture: u.value(forKey: "picture") as? String))
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return users
    }
    
}

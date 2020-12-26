//
//  User+CoreDataProperties.swift
//  
//
//  Created by admin on 22/12/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var picture: String?

}

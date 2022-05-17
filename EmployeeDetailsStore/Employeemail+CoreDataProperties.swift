//
//  Employeemail+CoreDataProperties.swift
//  
//
//  Created by Meghna on 17/05/22.
//
//

import Foundation
import CoreData


extension Employeemail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employeemail> {
        return NSFetchRequest<Employeemail>(entityName: "Employeemail")
    }

    @NSManaged public var emailID: String?
    @NSManaged public var categoryname: String?

}

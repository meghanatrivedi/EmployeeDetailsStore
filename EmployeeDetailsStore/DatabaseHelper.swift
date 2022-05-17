//
//  DatabaseHelper.swift
//  EmployeeDetailsStore
//
//  Created by Meghna on 17/05/22.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper{
    
   static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func saveEmail(Object:[String:String]){
        let Employeemail = NSEntityDescription.insertNewObject(forEntityName: "Employeemail", into: context!) as! Employeemail
        Employeemail.emailID = Object["emailID"]
        do{
            try context!.save()
        }catch let error {
            print("Data not saved \(error)")
        }
    }
    func deleteEmail(emailid : Int){
        let Employeemail = NSEntityDescription.insertNewObject(forEntityName: "Employeemail", into: context!) as! Employeemail
       
        context!.delete(Employeemail)

        // To delete the entity from the persistent store, call
        // save on the context
        do {
            try context!.save()
        }
        catch {
            // Handle Error
        }
        
        
        do{
            try context!.save()
        }catch{
            print("Data not saved")
        }
    }
}

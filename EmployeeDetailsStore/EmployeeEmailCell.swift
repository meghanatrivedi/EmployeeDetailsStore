//
//  EmployeeEmailCell.swift
//  EmployeeDetailsStore
//
//  Created by Meghna on 17/05/22.
//

import UIKit
import CoreData
import Foundation

class EmployeeEmailCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBOutlet weak var lblEmailValidation: UILabel!
   
    var parentCell:UITableViewCell!
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var receiveCategoryid = ""
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prePareCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension EmployeeEmailCell{
    func prePareCell(){
        //txtEmail.text = ""
        txtEmail.layer.cornerRadius = 5
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.black.cgColor
        
        txtEmail.delegate = self
    }
}
extension EmployeeEmailCell:UITextFieldDelegate{
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            let Employeemail = NSEntityDescription.insertNewObject(forEntityName: "Employeemail", into: context!) as! Employeemail
            
            if txtEmail.text!.isValidEmail() {
                lblEmailValidation.text = ""
                let dict = ["categoryname": receiveCategoryid ,"emailID": txtEmail.text!]
                DatabaseHelper.shareInstance.saveEmail(Object: dict )
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext(Object:dict)
//                let object = ["categoryname": "" ,"emailid": txtEmail.text ?? ""] as [String : String]
//                Employeemail.emailid = object["emailid"]
//                do{
//                    try context!.save()
//                    try (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.save()
//
//                }catch let error {
//                    print("Data not saved \(error)")
//                }
            }else if (txtEmail.text == Employeemail.emailID){
                lblEmailValidation.text = "Please use Diffrenert mail id"
            }
            else{
                lblEmailValidation.text = "Enter Vaild Email"
            }
            return true;
        }
}
extension EmployeeEmailCell{
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn{
            print("Switch on")
        }else {
            print("Switch off")
        }
    }
    
    @IBAction func btnRemoveAction(_ sender: UIButton) {
        print("Remove button click")
        
        if let parentCell = parentCell as? CategoryCell{
            parentCell.deleteemail(senderid:sender.tag)
        }
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

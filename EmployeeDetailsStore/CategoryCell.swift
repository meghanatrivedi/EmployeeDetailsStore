//
//  CategoryCell.swift
//  EmployeeDetailsStore
//
//  Created by Meghna on 17/05/22.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAddEmployeeid: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    
    var parentVC :UIViewController!
    var arrayCount :[String] = []
    var email = ""
    var receiveMailid = ""
    var receiveCategoryName = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        
        tblView.register(UINib(nibName: "EmployeeEmailCell", bundle: nil), forCellReuseIdentifier: "EmployeeEmailCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAddEmployeeIdAction(_ sender: UIButton) {
        arrayCount.append("1")
        tblView.reloadData()
        if let parentVC = parentVC as? ViewController{
            parentVC.tableviewReload(emailid:email, categoryid : sender.tag)
        }
    }
    
    func deleteemail(senderid:Int){
        arrayCount.remove(at: senderid)
        tblView.reloadData()
        if let parentVC = parentVC as? ViewController{
            parentVC.deleteEmail(emailidDelete: email, categoryidDelete: senderid, innerarrayCount: arrayCount.count)
            //(categoryidDelete: senderid, emailidDelete: email)
        }
    }
}
extension CategoryCell:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeEmailCell", for: indexPath) as! EmployeeEmailCell
        cell.parentCell = self
        cell.btnRemove.tag = indexPath.row
        email = cell.txtEmail.text ?? ""
        cell.receiveCategoryid = receiveCategoryName
//        if cell.txtEmail.text!.isValidEmail() {
//            cell.lblEmailValidation.text = ""
//        }else{
//            cell.lblEmailValidation.text = "Enter Vaild Email"
//        }
        //tblView.reloadData()
        return cell
    }
    
    
}

//
//  ViewController.swift
//  EmployeeDetailsStore
//
//  Created by Meghna on 17/05/22.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    
    let dropDown = DropDown()
    var categoryArray : [String] = []
    var array = ["Android","iOS","Web"]
    var emailid = ""

    @IBOutlet weak var btnEmployeeCategory: UIButton!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prePareUI()
    }

    @IBAction func btnEmployeeCategoryAction(_ sender: UIButton) {
        dropDown.show()
        dropDown.anchorView = btnEmployeeCategory
        dropDown.dataSource = array
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if categoryArray.contains(item){
                print("alredy have")
            }else{
            categoryArray.append(item)
            }
            tblView.reloadData()
            dropDown.hide()
        }
        dropDown.width = 200
    }
}
extension ViewController{
    func prePareUI(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        
        tblView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")

    }
    func tableviewReload(emailid:String , categoryid : Int){
        self.emailid = emailid
        let dict = ["categoryname": categoryArray[categoryid] ,"emailid": emailid]
        DatabaseHelper.shareInstance.saveEmail(Object: dict )
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext(Object:dict)
        tblView.reloadData()
//        tblView.layoutIfNeeded()
//        tblView.needsUpdateConstraints()
    }
    func deleteEmail(emailidDelete:String,categoryidDelete:Int,innerarrayCount:Int){
        let deleteEmail = ["categoryname": categoryArray[categoryidDelete] ,"emailid": emailidDelete]
        DatabaseHelper.shareInstance.deleteEmail(emailid: categoryidDelete)
        if innerarrayCount == 0{
            categoryArray.remove(at:categoryidDelete)
        }
        tblView.reloadData()
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.parentVC = self
        cell.btnAddEmployeeid.tag = indexPath.row
        cell.receiveMailid = emailid
        cell.receiveCategoryName = categoryArray[indexPath.row]
//        if categoryArray.contains(cell.lblTitle.text!){
//            print("You have the data")
//        }else{
        cell.lblTitle.text = categoryArray[indexPath.row]
//        }
        return cell
    }
    
    
}

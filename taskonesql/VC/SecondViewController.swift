//
//  SecondViewController.swift
//  taskonesql
//
//  Created by MANSVITA on 23/08/22.
//

import UIKit
import SQLite3
import CloudKit

// create Protocol
protocol datapassBack {
    func  userdataupdate(id:Int,firstname:String,lastname:String,email:String,phoneno:String,address:String)
}
class SecondViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: - Variable
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
//    var persondataarray: [Person]!
    var isedit = false
    var celldata : Cell!
    
    var delegate:datapassBack!
    
    var selecteddata = ""
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        tableview.delegate = self
        tableview.dataSource = self
        celldata = Cell()
        db.createTable()
        //persons = db.read()
  }
    override func viewWillAppear(_ animated: Bool) {
        persons = db.read()
    }
   

// alert display function

private func displayAlert(message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
}

//MARK: - Table View Delegate and DataSource
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.lblfirstname.text = persons[indexPath.row].firstname + " " + persons[indexPath.row].lastname
        print(cell)
        cell.lblphoneno.text = persons[indexPath.row].phoneno + " " + persons[indexPath.row].email
        cell.lbladdress.text = persons[indexPath.row].address
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.popViewController(animated: true)

        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // deletebutton
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "DELETE") { [self] (rowAction, indexpath) in
            if isedit == false{
               
              db.delete(id:self.persons[indexpath.row].id)
                self.persons.remove(at:indexpath.row )
                displayAlert(message:"your record delete ")
                tableView.deleteRows(at: [indexpath], with: .automatic)
            }else{
                displayAlert(message: "your record not deleted")
            }
            
           

          }
        
        //ediitbutton
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [self] (rowAction, indexpath) in
            self.delegate?.userdataupdate(id:persons[indexpath.row].id,firstname:self.persons[indexpath.row].firstname , lastname: self.persons[indexpath.row].lastname, email: self.persons[indexpath.row].email, phoneno:self.persons[indexpath.row].phoneno, address:self.persons[indexpath.row].address)
         

        self.navigationController?.popViewController(animated: true)
        }
    
        deleteAction.backgroundColor = .orange
        editAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        return [deleteAction,editAction]
        
        
    }
   
}






























    
// DELETE...............OPERATION

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete{
//            let alert = UIAlertController(title: "", message: "Are you sure you want to delete?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
//                self.db.delete(firstname:self.persons[indexPath.row].firstname, lastname: self.persons[indexPath.row].lastname, email: self.persons[indexPath.row].email, phoneno: self.persons[indexPath.row].phoneno, address: self.persons[indexPath.row].address)
//                self.persons = self.db.read()
//
//
//                self.persondata = self.persons
//                self.tableview.reloadData()
//                self.tableview.isHidden = true
//                                if self.persondata.count > 0 {
//                self.tableview.reloadData()
//                } else {
//                    self.tableview.isHidden = true
//                }
//            }))
//
//            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
//                print("NO")
//            }))
//            self.present(alert, animated: true)
//       }
//self.db.update(firstname:self.persons[indexpath.row].firstname, lastname: self.persons[indexpath.row].lastname, email: self.persons[indexpath.row].email, phoneno: self.persons[indexpath.row].phoneno, address: self.persons[indexpath.row].address)

//
//
//    }
//
    
//if isedit == false{
//    db.update(firstname: "zarna", lastname: "patel", email: "zarna@gmail.com", phoneno: "1231231233", address: "bhavnagar")
//}else{
//    print(isedit)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

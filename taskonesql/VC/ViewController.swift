//
//  ViewController.swift
//  taskonesql
//
//  Created by MANSVITA on 22/08/22.
//

import UIKit
import CloudKit

class ViewController: UIViewController{
    
    // outlet textfield
    
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphoneno: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    
    
    // outlet button
    @IBOutlet weak var btnload: UIButton!
    @IBOutlet weak var btnsave: UIButton!
    
    //Variable Declaration
    var validation = Validation()
    var selecteddata:String = ""
    var persons:Person!
    var db:DBHelper = DBHelper()
    var isedit = false
    var personid:Int = 0
    // image set
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "gsky")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtfirstname.text = "anjali"
        txtlastname.text = "patel"
        txtemail.text = "patel@gmail.com"
        txtaddress.text = "abcdgujratjjjjjjjj"
        txtphoneno.text = "1231237890"
      
//        // textfield delegate
//        txtemail.delegate = self
//        txtaddress.delegate = self
//        txtlastname.delegate = self
//        txtphoneno.delegate = self
//        txtfirstname.delegate = self
//
        // save button design
        btnsave.layer.cornerRadius = 20
        btnsave.backgroundColor = .systemBlue
        btnsave.clipsToBounds = true
       // db.read()
        db.createTable()
        // load button design
        
        btnload.layer.cornerRadius = 20
        btnload.backgroundColor = .black
        btnload.clipsToBounds = true
       
        // imageview autolayout
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
       
        
    }
    // alert display function
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
        
    // load button
    
    @IBAction func btnload(_ sender: Any) {
        guard let secondviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        secondviewcontroller.delegate = self
        self.navigationController?.pushViewController(secondviewcontroller, animated: true)
        
        }
    
   

    // save Button
    
    @IBAction func btnsave(_ sender: Any) {
        
        
        guard let firstname = txtfirstname.text, let lastname = txtlastname.text,
              let email = txtemail.text,
              let phoneno = txtphoneno.text,
              let address = txtaddress.text
        else {
           return
        }
        
             let isValidatfirstname = self.validation.firstname(firstname: firstname)
             if (isValidatfirstname == false) {
               displayAlert(message: "invalid firstname")
                return
             }
        let isValidateemail = self.validation.email(email: email)
             if (isValidateemail == false) {
              displayAlert(message: "invalid email")
                return
             }
        let isValidatelastname = self.validation.lastname(lastname: lastname)
             if (isValidatelastname == false) {
              displayAlert(message: "invalid lastname")
                return
             }
        let isValidatePhoneno = self.validation.Phoneno(phoneno: phoneno)
             if (isValidatePhoneno == false) {
             displayAlert(message: "invalid phoneno")
                return
             }
        let isValidateaddress = self.validation.address(address: address)
             if (isValidateaddress == false) {
               displayAlert(message: "invalid address")
                return
             }
        

        else if(isedit == false ){
                 
    self.db.insert(firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
                 
        }else {
                 
        self.db.update(id:personid,firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
                 
                                     self.txtemail.text = nil
                                     self.txtphoneno.text = nil
                                     self.txtfirstname.text = nil
                                     self.txtlastname.text = nil
                                     self.txtaddress.text = nil
                 
                displayAlert(message: "your data save")
                 
        
          }
        
    }
        
}
extension ViewController : datapassBack{
        func userdataupdate(id:Int,firstname: String, lastname: String, email: String, phoneno: String, address: String) {

           personid = id
            txtfirstname.text = firstname
            txtlastname.text = lastname
            txtemail.text = email
            txtphoneno.text = phoneno
            txtaddress.text = address
          
                  
        }
    }


        
        
        
        
        
        
        
  //validation condition all field are correct
        
//             if ( isValidatfirstname == true || isValidateemail == true || isValidatelastname == true || isValidatePhoneno == true ||  isValidateaddress == true ) {
//              displayAlert(message: "all field are correct")
             //}
        
        
        
        
        
//        let firstname = txtfirstname.text ?? ""
//        let lastname = txtlastname.text ?? ""
//        let phoneno = txtphoneno.text ?? ""
//        let email = txtemail.text ?? ""
//        let address = txtaddress.text ?? ""
//
//        if (firstname.isEmpty == "" && lastname.isEmpty == "" && email.isEmpty == ""  && address.isEmpty == ""){
//          displayAlert(message: "your detail not set")

//            if (firstname.isEmpty){
//                displayAlert(message: "please enter firstname")
//            }else if(lastname.isEmpty){
//                displayAlert(message: "please enter lastname")
//            }else if(phoneno.isEmpty){
//                displayAlert(message: "please enter phoneno")
//            }else if (address.isEmpty){
//                displayAlert(message: "please enetr address")
//            }else if (phoneno.isEmpty){
//                displayAlert(message: "please eneter phoneno")
//            }else if(isedit == true){
//
//            self.db.insert(firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
//
//
//                }else {
//
//                self.db.update(id:personid,firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
//
//                    self.txtemail.text = nil
//                    self.txtphoneno.text = nil
//                    self.txtfirstname.text = nil
//                    self.txtlastname.text = nil
//                    self.txtaddress.text = nil
//
//                    displayAlert(message: "your data save")
//
//
//                    }
//                   }
//
//
        

// textfielddelegate validation

//extension ViewController : UITextFieldDelegate{
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        switch (textField.tag)
//        {
//        case 1:
//
//            txtfirstname.becomeFirstResponder()
//
//        case 2 :
//
//            txtlastname.becomeFirstResponder()
//
//        case 3 :
//
//            txtemail.becomeFirstResponder()
//
//        case 4 :
//
//            txtphoneno.becomeFirstResponder()
//
//        case 5 :
//
//            txtaddress.becomeFirstResponder()
//        case 6 :
//
//            txtaddress.resignFirstResponder()
//
//        default: break
//        }
//        return true
//
//    }
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool
//    {
//        return true
//    }
//
//
//    func textFieldDidEndEditing(_ textField: UITextField)
//
//    {
//        // firstname validation
//        if (textField == txtfirstname)
//        {
//            let name_reg = "[A-Za-z0-9]{5,20}"
//
//            let name_test = NSPredicate(format: "SELF MATCHES %@", name_reg)
//
//            if name_test.evaluate(with: txtfirstname.text) == false
//            {
//                let alert = UIAlertController(title: "Information", message: "Enter the firstname in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//
//        // lastname validation
//
//        if (textField == txtlastname)
//        {
//            let name_reg = "[A-Za-z0-9]{5,20}"
//
//            let name_test = NSPredicate(format: "SELF MATCHES %@", name_reg)
//
//            if name_test.evaluate(with: txtlastname.text) == false
//            {
//                let alert = UIAlertController(title: "Information", message: "Enter the name in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//
//        // Email validation
//
//        if (textField == txtemail){
//
//            let email_add = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//            let email_test = NSPredicate(format: "SELF MATCHES %@", email_add)
//            if email_test.evaluate(with: txtemail.text) == false
//            {
//                let alert = UIAlertController(title: "Information", message: "Enter your E-mail Correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//
//        // phoneno validation
//
//        if (textField == txtphoneno)
//        {
//            let name_reg = "[0-9]{10}"
//
//            let name_test = NSPredicate(format: "SELF MATCHES %@", name_reg)
//
//            if name_test.evaluate(with: txtphoneno.text) == false
//            {
//                let alert = UIAlertController(title: "Information", message: "Enter your Phonenumber in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//
//        // address validation
//
//        if (textField == txtaddress)
//        {
//            let address_detail = "[A-Za-z0-9]"
//
//            let add_test = NSPredicate(format: "SELF MATCHES %@", address_detail)
//
//            if add_test.evaluate(with: txtaddress.text) == false
//            {
//                let alert = UIAlertController(title: "Information", message: "Enter your Address in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                //self.present(alert, animated: true, completion: nil)
//            }
//        }
//
//
//    }
//
//}


//  extension delegate








//else if isedit == true{
//
//    self.db.update(firstname:self.txtfirstname.text! ,lastname:self.txtlastname.text!, email: self.txtemail.text!, phoneno:self.txtphoneno.text!, address: self.txtaddress.text!)
//}
//else {
//
//    self.db.insert(firstname:txtfirstname.text! , lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)

  
    
    
    /****text field validation********/
    
    //        if (firstname == "[A-Za-z0-9]{5,20}" && lastname == "[A-Za-z0-9]{5,20}" && email  ==  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" && phoneno == "[0-9]{10}" && address == "[A-Za-z0-9]{18,50}"){
    //
    //            displayAlert(message: "All detail are set")
    //
    //        }else if(firstname == "[A-Za-z0-9]{5,20}"){
    //            displayAlert(message: "firstname correct format")
    //        }else if firstname.isEmpty{
    //
    //            displayAlert(message: "firstname incorrect format")
    //        }
    //        else if(lastname == "[A-Za-z0-9]{5,20}"){
    //            displayAlert(message: "lastname correct format")
    //        }else if lastname.isEmpty{
    //
    //            displayAlert(message: "lasstname incorrect format")
    //        }else if (email == "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"){
    //            displayAlert(message: "email is correct formate")
    //        }else if (email.isEmpty){
    //            displayAlert(message: "email is incorrect formate")
    //        }else if (phoneno == "[0-9]{10}"){
    //            displayAlert(message: "email is correct formate")
    //        }else if phoneno.isEmpty{
    //            displayAlert(message: "email is incorrect formate")
    //        }else if (address == "[A-Za-z0-9]{18,50}"){
    //            displayAlert(message: "address is correct formate")
    //        }else if (address == "[A-Za-z0-9]{18,50}"){
    //            displayAlert(message: "address is correct formate")
    //        }else if (address.isEmpty){
    //             displayAlert(message: "address is incorrect formate")
    //        }else if isedit == true{
    //
    //                        self.db.insert(firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
    //
    //
    //                    }else {
    //
    //                        self.db.update(id:personid,firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
    //
    //                        self.txtemail.text = nil
    //                        self.txtphoneno.text = nil
    //                        self.txtfirstname.text = nil
    //                        self.txtlastname.text = nil
    //                        self.txtaddress.text = nil
    //
    //                        displayAlert(message: "your data save")
    //
    //
    //                   }
    //
        

    //        if (firstname.isEmpty && lastname.isEmpty && email.isEmpty && phoneno.isEmpty && address.isEmpty) {
    //            displayAlert(message: " All detail are not set")
                
    //            return
    //        }else if(firstname == "[A-Za-z0-9]{5,20}" ) {
    //            displayAlert(message: "firstname is incorrect format")
    //        }else if (firstname.isEmpty){
    //            displayAlert(message: "firstname is incorrect format")
    //            return
    //        }else if (lastname == "[A-Za-z0-9]{5,20}"){
    //
    //        }
            
    //        }else if(lastname.isEmpty) {
    //            displayAlert(message: "lastname is not set")
    //            return
    //        }else if(email.isEmpty) {
    //            displayAlert(message: "email is not set")
    //            return
    //        }else if (phoneno.isEmpty) {
    //            displayAlert(message: "phoneno is not set")
    //            return
    //        }else if (address.isEmpty) {
    //            displayAlert(message: "address is not set")
    //            return
    //else if isedit == Bool(){
    //
    //            self.db.insert(firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
    //
    //
    //        }else {
    //
    //            self.db.update(id:personid,firstname: txtfirstname.text!, lastname: txtlastname.text!, email: txtemail.text!, phoneno: txtphoneno.text!, address: txtaddress.text!)
    //
    //            self.txtemail.text = nil
    //            self.txtphoneno.text = nil
    //            self.txtfirstname.text = nil
    //            self.txtlastname.text = nil
    //            self.txtaddress.text = nil
    //
    //            displayAlert(message: "your data save")
    //
    //
    //       }
    //}
    //


   

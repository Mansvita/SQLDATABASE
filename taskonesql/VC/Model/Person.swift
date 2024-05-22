//
//  Person.swift
//  taskonesql
//
//  Created by MANSVITA on 23/08/22.
//

import Foundation


class Person
{
  var id:Int 
    var firstname:String = ""
    var lastname:String = ""
    var email:String = ""
    var phoneno:String = ""
    var address:String = ""
    
    init(id:Int,firstname:String,lastname:String,email:String,phoneno:String,address:String)
    {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phoneno = phoneno
        self.address = address
    }
    
}

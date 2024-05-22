//
//  DBHelper.swift
//  taskonesql
//
//  Created by MANSVITA on 23/08/22.
//

import Foundation
import SQLite3
class DBHelper{
   static  var shareinstance = DBHelper()
    
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    // create table
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY AUTOINCREMENT ,firstname TEXT,lastname TEXT,email TEXT,phoneno TEXT , address TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // insert querry
    func insert(firstname:String,lastname:String,email:String,phoneno:String,address:String)
    {
        
       
        let insertStatementString = "INSERT INTO person (firstname,lastname, email,phoneno,address) VALUES (?, ?, ?, ?,?);"
        var insertStatement: OpaquePointer? 
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
           
            sqlite3_bind_text(insertStatement, 1, (firstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (lastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (phoneno as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (address as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // read querry
    
    func read() -> [Person] {
            let queryStatementString = "SELECT * FROM person;"
            var queryStatement: OpaquePointer? = nil
            var psns : [Person] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                   
                    let id = sqlite3_column_int(queryStatement, 0)
                    let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let lastname = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    let phoneno = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    let address = String(describing: String(cString: sqlite3_column_text(queryStatement,5)))
                    
                    
                    psns.append(Person(id:Int(id) , firstname: firstname,lastname: lastname,email: email,phoneno: phoneno,address: address))
                   

                    print("Query Result:")
                   print(" \(id) \(firstname) | \(lastname) | \(email) | \(phoneno) | \(address)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return psns
    }
    
    
 

    // update querry
    
    func update( id:Int,firstname:String,lastname:String,email:String,phoneno:String,address:String) {
            var updateStatement: OpaquePointer? = nil
       
        let updateStatementString = "UPDATE person SET firstname = '\(firstname)', lastname = '\(lastname)', email = '\(email)', phoneno = '\(phoneno)', address = '\(address)'WHERE id = \(id);"
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("\nSuccessfully updated row.")
                    print(" \(id) | \(firstname) | \(lastname) | \(email) | \(phoneno) | \(address)")
                } else {
                    print("\nCould not update row.")
                }
            } else {
                print("\nUPDATE statement is not prepared")
            }
            sqlite3_finalize(updateStatement)
        }
    

    
   func delete(id: Int) {
            let deleteStatementStirng = "DELETE FROM person WHERE id = \(id);"
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            sqlite3_finalize(deleteStatement)
        }


}


//
//  DBHelper.swift
//  SQLITE Project
//
//  Created by Prince's Mac on 30/07/22.
//

import Foundation
import SQLite3

class DBHelper{
    init(){
        db = openDataBase()
        createTable()
    }
    let dbPaath: String = "myDb.sqlite"
    var db : OpaquePointer?
    func openDataBase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create : false)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("There is an error while opening the database")
            return nil
        }else {
            print("Database opened successfully \(dbPaath)")
            return db
        }
    }
    func createTable() {
        let createTableString  = "CREATE TABLE IF NOT EXISTS Person(id INT, name TEXT, age INT);"
        var createTableStatement : OpaquePointer? = nil
      
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("the person table you wanted to create has been created")
            }else {
                print("Table creation failed")
            }
        }else {
            print("Create statement prepration failed")
        }
        sqlite3_finalize(createTableStatement)
    }
    func insertData(id:Int, name: String, age:Int){
        let persons = read()
        for p in persons{
            if  (p.id == id)
            {return}
    }
        let insertStatementString =  "INSERT INTO Person (id,name,age) VALUES(?,?,?);"
        var insertStatement :OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Successful insertion of record")
            } else {
                print("The record insertion failed")
            }
        }
        sqlite3_finalize(insertStatement)
}
    func read() -> [Person]{
        let queryStatementString = "SELECT * from Person;"
        var queryStatement : OpaquePointer? = nil
            
            var p1 : [Person] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_ROW {
            let id = sqlite3_column_int(queryStatement, 0)
            let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let age = sqlite3_column_int(queryStatement, 2)
            
            p1.append(Person(id: Int(id), name: name, age : Int (age)))
            print("The query is executed \(id)")
            
        }else{
            print("Query Statement Is Not Prepared")
        }
        sqlite3_finalize(queryStatement)
        return p1
    }
}


//
//  Person.swift
//  SQLITE Project
//
//  Created by Prince's Mac on 30/07/22.
//

import Foundation
class Person{
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
    init(id:Int, name:String,age:Int){
        self.id = id
        self.name = name
        self.age = age
    }
}

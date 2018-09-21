//
//  StudentData.swift
//  StudentTableView
//
//  Created by iOS Dev on 9/21/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class StudentData: NSObject {
    var studentList:[Student]=[]
    
    func add(student:Student) {
        studentList.append(student)
    }
    
    func add(firstName:String, lastName:String, year:Int) {
        let student = Student(firstName: firstName, lastName: lastName, year: year)
        add(student: student)
    }
    
    func addAt(index:Int, student:Student) {
        studentList.insert(student, at: index)
    }
    
    func getAt(index:Int) -> Student {
        return studentList[index]
    }
    
    func deleteAt(index:Int) -> Student {
        return studentList.remove(at: index)
    }
}

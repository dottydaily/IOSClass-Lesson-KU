//
//  Student.swift
//  StudentTableView
//
//  Created by iOS Dev on 9/21/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class Student: NSObject {
    var firstName:String
    var lastName:String
    var year:Int
    
    init(firstName:String, lastName:String, year:Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.year = year
    }
    
    convenience init(random: Bool = false) {
        if random {
            let firstN:[String] = ["Somsri", "Nakorn", "Pornprapha"]
            let lastN:[String] = ["Yuenyong", "Ruksa-ard", "Chomchob"]
            
            var idx = arc4random_uniform(UInt32(firstN.count))
            
            self.init(firstName: firstN[Int(idx)], lastName: lastN[Int(idx)], year: Int(arc4random_uniform(5)))
        }
        else {
            self.init(firstName: "-", lastName: "-", year: 0)
        }
    }
}

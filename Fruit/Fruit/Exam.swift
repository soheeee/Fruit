//
//  Exam.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Exam:Item{
    
    var subject:String
    var memo:String
    var location:String
    
    enum category{
        case Midterm
        case Final
        case Quiz
    }
    
    init(id: Int, time: NSCalendar, subject:String, memo:String, location:String) {
        
        super.init(id: <#T##Int#>, time: <#T##NSCalendar#>)
        
        self.subject = subject
        self.memo = memo
        self.location = location
        
    }
    
}
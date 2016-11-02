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
        case midterm
        case final
        case quiz
    }
    
    init(id: Int, time: NSCalendar, subject:String, memo:String, location:String) {
		self.subject = subject
		self.memo = memo
		self.location = location
		
        super.init(id: id, time: time)
    }
}

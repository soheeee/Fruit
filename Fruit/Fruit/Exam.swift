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
    
    enum category:Int{
        case midterm = 0
        case final = 1
        case quiz = 2
    }
    
    var cateArray = ["midterm","final","quiz"]
    
    init(id: Int, time: NSCalendar, subject:String, memo:String, location:String, cate: category) {
		self.subject = subject
		self.memo = memo
		self.location = location
		
        super.init(id: id, title: cateArray[cate.rawValue], time: time)
    }
}

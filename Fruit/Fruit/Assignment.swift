//
//  Assignment.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Assignment:Item{
    
    var name:String
    var subject:String
    var memo:String
    
    enum category{
        case assignment
        case project
        case teamProject
        case presentation
    }
    
    init(id: Int, time: NSCalendar, name: String, subject:String, memo:String) {
		self.name = name
		self.subject = subject
		self.memo = memo
		
        super.init(id: id, title: name, time: time)
	}
}

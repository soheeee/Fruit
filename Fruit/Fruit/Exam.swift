//
//  Exam.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Exam:Item{
    
    var memo:String = "def"
    var location:String = "def"
    var type:type = Exam.type(rawValue: 0)!
    
    enum type:Int{
        case midterm = 0
        case final = 1
        case quiz = 2
        case etc = 3
    }
    
    static var typeArray = ["중간고사","기말고사","퀴즈","기타"]
    
    init(){
        
        super.init(id: -1, title: "Title", time: NSDate(), subFull: "Fullname", subShort: "Shortname")
        
    }
    
    init(id: Int, time: NSDate, subFull:String, subShort:String, memo:String, location:String, type: type) {
		self.memo = memo
		self.location = location
		
        super.init(id: id, title: Exam.typeArray[type.rawValue], time: time, subFull: subFull, subShort:subShort)
    }
	
	required init?(coder aDecoder: NSCoder) {
		self.memo = aDecoder.decodeObject(forKey: "memo") as! String
		self.location = aDecoder.decodeObject(forKey: "location") as! String
        self.type = Exam.type(rawValue:aDecoder.decodeInteger(forKey: "type"))!
		
		super.init(coder: aDecoder)
	}
	
	override func encode(with aCoder: NSCoder) {
		aCoder.encode(self.memo, forKey:"memo")
		aCoder.encode(self.location, forKey:"location")
        aCoder.encode(self.type.rawValue, forKey:"type")
		
		super.encode(with: aCoder)
	}
}

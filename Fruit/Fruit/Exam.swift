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
    
    enum category:Int{
        case midterm = 0
        case final = 1
        case quiz = 2
    }
    
    var cateArray = ["midterm","final","quiz"]
    
    init(id: Int, time: NSDate, subFull:String, subShort:String, memo:String, location:String, cate: category) {
		self.memo = memo
		self.location = location
		
        super.init(id: id, title: cateArray[cate.rawValue], time: time, subFull: subFull, subShort:subShort)
    }
	
	required init?(coder aDecoder: NSCoder) {
		self.memo = aDecoder.decodeObject(forKey: "memo") as! String
		self.location = aDecoder.decodeObject(forKey: "location") as! String
		
		super.init(coder: aDecoder)
	}
	
	override func encode(with aCoder: NSCoder) {
		aCoder.encode(self.memo, forKey:"memo")
		aCoder.encode(self.location, forKey:"location")
		
		super.encode(with: aCoder)
	}
}

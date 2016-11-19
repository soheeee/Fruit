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
    var memo:String
    
    enum category{
        case assignment
        case project
        case teamProject
        case presentation
    }
    
    init(id: Int, time: NSDate, name: String, subFull:String, subShort:String, memo:String) {
		self.name = name
		self.memo = memo
		
        super.init(id: id, title: name, time: time, subFull:subFull, subShort:subShort)
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObject(forKey: "name") as! String
		self.memo = aDecoder.decodeObject(forKey: "memo") as! String
		
		super.init(coder: aDecoder)
	}
	
	override func encode(with aCoder: NSCoder) {
		aCoder.encode(self.name, forKey:"name")
		aCoder.encode(self.memo, forKey:"memo")
		
		super.encode(with: aCoder)
	}
}

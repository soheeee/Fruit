//
//  Assignment.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Assignment:Item{
    
    var name:String = "def"
    var memo:String = "def"
    var type:type = Assignment.type(rawValue: 0)!
    
    enum type:Int{
        case assignment = 0
        case project = 1
        case teamProject = 2
        case presentation = 3
    }
    
    static var typeArray = ["과제", "프로젝트", "팀플", "발표"]
    
    init(){
        
        super.init(id: -1, title: "Title", time: NSDate(), subFull: "Fullname", subShort: "Shortname")
        
    }
    
    init(id: Int, time: NSDate, name: String, subFull:String, subShort:String, memo:String, type:type) {
		self.name = name
		self.memo = memo
        self.type = type
		
        super.init(id: id, title: name, time: time, subFull:subFull, subShort:subShort)
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObject(forKey: "name") as! String
		self.memo = aDecoder.decodeObject(forKey: "memo") as! String
        self.type = Assignment.type(rawValue:aDecoder.decodeInteger(forKey: "type"))!
		
		super.init(coder: aDecoder)
	}
	
	override func encode(with aCoder: NSCoder) {
		aCoder.encode(self.name, forKey:"name")
		aCoder.encode(self.memo, forKey:"memo")
        aCoder.encode(self.type.rawValue, forKey:"type")
		
		super.encode(with: aCoder)
	}
}

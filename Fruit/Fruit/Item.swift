//
//  FruitModelClass.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding{
    
    var id:Int
    var time:NSDate
    var title:String = "def"
    var subFull:String = "def"
    var subShort:String = "def"
    
    init(id:Int, title:String, time:NSDate, subFull: String, subShort: String){
        self.id = id
        self.title = title
        self.time = time
        self.subFull = subFull
        self.subShort = subShort
    }
    
	required init?(coder aDecoder: NSCoder) {
		self.id = aDecoder.decodeInteger(forKey: "id")
		self.title = aDecoder.decodeObject(forKey: "title") as! String
		self.time = aDecoder.decodeObject(forKey: "time") as! NSDate
        self.subFull = aDecoder.decodeObject(forKey: "subFull") as! String
        self.subShort = aDecoder.decodeObject(forKey: "subShort") as! String
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.id, forKey: "id")
		aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.time, forKey:"time")
        aCoder.encode(self.subFull, forKey:"subFull")
        aCoder.encode(self.subShort, forKey:"subShort")
	}
}

//
//  FruitModelClass.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Item: NSCoding{
    
    var id:Int
    var time:NSCalendar
    var title:String
    
    init(id:Int, title:String, time:NSCalendar){
        self.id = id
        self.title = title
        self.time = time
    }
    
	required init?(coder aDecoder: NSCoder) {
		self.id = aDecoder.decodeObject(forKey: "id") as! Int
		self.title = aDecoder.decodeObject(forKey: "title") as! String
		self.time = aDecoder.decodeObject(forKey: "time") as! NSCalendar
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.id, forKey: "id")
		aCoder.encode(self.title, forKey: "title")
		aCoder.encode(self.time, forKey:"time")
	}
}

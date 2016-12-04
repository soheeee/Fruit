//
//  Subject.swift
//  Fruit
//
//  Created by Jin Park on 04/12/2016.
//  Copyright © 2016 소희. All rights reserved.
//

import Foundation

class Subject: NSObject, NSCoding {
    var name:String = ""
    var short:String = ""
    
    init(name: String, short: String) {
        self.name = name
        self.short = short
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.short = aDecoder.decodeObject(forKey: "short") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.short, forKey: "short")
    }
}

//
//  FruitModelClass.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

class Item{
    
    var id:Int
    var time:NSCalendar
    var title:String
    
    init(id:Int, title:String, time:NSCalendar){
    
        self.id = id
        self.title = title
        self.time = time
    
    }
    
}

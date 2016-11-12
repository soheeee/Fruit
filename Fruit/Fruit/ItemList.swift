//
//  ItemList.swift
//  Fruit
//
//  Created by Jin Park on 13/11/2016.
//  Copyright © 2016 소희. All rights reserved.
//

import Foundation

let itemList = ItemList()

class ItemList {
	var items : [Item] = [] // TODO: It would be better to change type to List.
	let fileName = "ItemList.list"
	
	var filePath:String {
		get {
			let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
			return documentDirectory + fileName
		}
	}
	
	init() {
		if FileManager.default.fileExists(atPath: filePath)	{
			// If the file exists (normal)
			if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
				items += unarchArray
			}
		} else {
			// If ths file does not exist (at first time app launch)
			// Create Tutorial Items
			items += tutorialData()
		}
	}
	
	func saveItems() {
		// Use when create, edit or delete item
		NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
	}
	
	func tutorialData() -> [Item] {
		let dummyAssignment = Assignment(id: 0, time: NSCalendar.current as NSCalendar, name: "TestAssignment", subject: "TestSubject", memo: "TestMemo")
		let dummyExam = Exam(id: 1, time: NSCalendar.current as NSCalendar, subject: "dummySubject", memo: "dummyMemo", location: "dummyLocation", cate: Exam.category.quiz)
		return [dummyAssignment, dummyExam]
	}
}

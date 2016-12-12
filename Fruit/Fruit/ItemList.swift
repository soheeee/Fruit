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
	let fileName = "/ItemList.list"
	
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
        // TODO: Change date to special day
        let dummyAssignment = Assignment(id: 0, time: NSDate(timeIntervalSinceNow: 999999), name: "길게 눌러 삭제", subject: subjectList.newSubject(name: "TutorialSubject", short: "튜토리얼"), memo: "TestMemo", type:Assignment.type.assignment)
//        let dummyExam = Exam(id: 1, time: NSDate(timeIntervalSinceNow: 999999), subject: subjectList.newSubject(name: "TutorialSubject", short: "TS"),  memo: "dummyMemo", location: "dummyLocation", type: Exam.type.quiz)
		return [dummyAssignment]
//        , dummyExam]
	}
	
	func createDummy() {
        // It creates an item which ends 9999secs later
        let dummyItem = Item(id: -1, title: "dummy" + String(items.count), time: NSDate(timeIntervalSinceNow: 9999), subject: subjectList.newSubject(name: "longname", short: "short"))
		
		items += [dummyItem]
		
		saveItems()
	}
    
    func finishItem(item: Item) {
        items[items.index(of:item)!].id += 10;
        
        saveItems()
    }
	
    func deleteItem(item: Item) {
        items = items.filter({$0 != item})
        
		saveItems()
	}
    
    func insertItem(item: Item) {
        items += [item]
        
        saveItems()
    }
    
    func changeItem(from: Item, to: Item) {
        items = items.filter({$0 != from})
        items += [to]
        
        saveItems()
    }
    
    func getItemsFromNow() -> [Item] {
        let today = Date()
        
        return items.filter({$0.time as Date > today && $0.id < 2})
    }
}

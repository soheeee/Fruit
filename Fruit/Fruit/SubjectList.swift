//
//  SubjectList.swift
//  Fruit
//
//  Created by Jin Park on 04/12/2016.
//  Copyright © 2016 소희. All rights reserved.
//

import Foundation

let subjectList = SubjectList()

class SubjectList {
    var subjects:[Subject] = []
    
    let fileName = "/SubjectList.list"
    
    var filePath:String {
        get {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return documentDirectory + fileName
        }
    }
    
    init() {
        if FileManager.default.fileExists(atPath: filePath)	{
            // If the file exists (normal)
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Subject] {
                subjects += unarchArray
            }
        } else {
            // If ths file does not exist (at first time app launch)
            // Create Tutorial Subjects
            subjects += tutorialData()
        }
    }
    
    func saveSubjects() {
        // Use when create, edit or delete subject
        NSKeyedArchiver.archiveRootObject(subjects, toFile: filePath)
    }
    
    func tutorialData() -> [Subject] {
        // TODO: Change date to special day
        let one = Subject(name: "길다란 이름", short: "짧이름")
        let two = Subject(name: "롱롱네임", short: "숏네임")
        return [one, two]
    }
    
    func deleteSubject(at: Int) {
        subjects.remove(at: at)
        
        saveSubjects()
    }
    
    func deleteSubject(subject: Subject) {
        subjects = subjects.filter({$0 != subject})
        
        saveSubjects()
    }
    
    func insertSubject(subject: Subject) {
        subjects += [subject]
        
        saveSubjects()
    }
}

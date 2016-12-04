//
//  AddAssignmentViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class AddAssignmentViewController: ItemViewController {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet var name : UITextField! = UITextField()
    @IBOutlet var memo : UITextField! = UITextField()
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet var category : UITextField! = UITextField()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subject: UITextField!
    
    var isEditmode:Bool = false
    var assignmentToEdit:Assignment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        name.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
        categories += Assignment.typeArray
        collectionViewForItem = collectionView
        subjectForItem = subject
        
        if isEditmode {
            titleText.text = "과제 수정"
            loadAssignment()
        }
    }
    
    func loadAssignment() {
        if assignmentToEdit == nil {
            print("failToLoad")
            return
        }
        
        let data = assignmentToEdit!
        self.name.text = data.name
        self.memo.text = data.memo
        self.dateVar = data.time as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        self.date.setTitle(dateFormatter.string(from: dateVar), for: .normal)
        dateFormatter.dateFormat = "h:mm a"
        self.time.setTitle(dateFormatter.string(from: dateVar), for: .normal)
        self.category.text = categories[data.type.rawValue]
        self.subject.text = data.subject.name
        self.selectedSubject = data.subject
    }
    
    @IBAction func chooseCategory(_ sender: Any){
        chooseCategoryForItem(title: "카테고리", sender: sender, category: self.category)
    }
    
    @IBAction func addAssignment(_ sender: Any) {
        if name.text != "" {
            var categoryType:Assignment.type = Assignment.type.assignment
            for i in 0 ... categories.count-1 {
                if category.text == categories[i] {
                    categoryType = Assignment.type(rawValue: i)!
                }
            }
            
            let assignment = Assignment(id: 0, time: dateVar as NSDate, name: name.text!, subject: selectedSubject, memo: memo.text!, type:categoryType)
            
            if isEditmode {
                itemList.changeItem(from: assignmentToEdit!, to: assignment)
            } else {
                itemList.insertItem(item: assignment)
            }
            
            self.dismiss(animated: true, completion: nil)
        } else {
            /*
             let alert = UIAlertController(title: "입력 오류", message: "빈칸을 모두 입력해주세요", preferredStyle: .alert)
             
             alert.view.tintColor = blushTwo
             
             alert.addAction(UIAlertAction(title: "확인", style: .default))
             
             self.present(alert, animated: true, completion: nil)
             */
        }
    }
    
    @IBAction func viewClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addSubjectPressed(sender: UIButton){
        addSubjectForItem(subject: subject)
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        chooseDateForItem(sender: sender)
    }
    
    @IBAction func chooseTime(_ sender: UIButton) {
        chooseTimeForItem(sender:sender)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

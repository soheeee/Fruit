//
//  AddExamViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

class AddExamViewController: ItemViewController {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var subject: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isEditmode:Bool = false
    var examToEdit:Exam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        memo.inputAccessoryView = toolBar
        categories += Exam.typeArray
        collectionViewForItem = collectionView
        subjectForItem = subject
        
        if isEditmode {
            titleText.text = "시험 수정"
            loadExam()
        }
    }
    
    func loadExam() {
        if examToEdit == nil {
            print("failToLoad")
            return
        }
        
        let data = examToEdit!
        self.type.text = Exam.typeArray[data.type.rawValue]
        self.dateVar = data.time as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        self.date.setTitle(dateFormatter.string(from: dateVar), for: .normal)
        dateFormatter.dateFormat = "h:mm a"
        self.time.setTitle(dateFormatter.string(from: dateVar), for: .normal)
        
        self.memo.text = data.memo
        self.subject.text = data.subject.name
        self.selectedSubject = data.subject
    }
    
    
    @IBAction func viewClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addExam(_ sender: Any) {
        if(type.text != "") {
            var examType:Exam.type?
            for i in 0 ... categories.count-1 {
                if type.text == categories[i] {
                    examType = Exam.type(rawValue: i)
                }
            }
            
            let exam = Exam(id: 1, time: dateVar as NSDate, subject: selectedSubject, memo: memo.text!, location: memo.text!, type: examType!)
            
            if isEditmode {
                itemList.changeItem(from: examToEdit!, to: exam)
            } else {
                itemList.insertItem(item: exam)
            }
            
            self.dismiss(animated: false, completion: nil)
        } else {
            /*
             let alert = UIAlertController(title: "입력 오류", message: "빈칸을 모두 입력해주세요", preferredStyle: .alert)
             
             alert.view.tintColor = blushTwo
             
             alert.addAction(UIAlertAction(title: "확인", style: .default))
             
             self.present(alert, animated: true, completion: nil)
             */
        }
    }
    
    @IBAction func chooseExamType(_ sender: Any) {
        chooseCategoryForItem(title: "시험종류", sender: sender, category: type)
    }
    
    @IBAction func addSubject(_ sender: Any) {
        addSubjectForItem(subject: subject)
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        chooseDateForItem(sender: sender)
    }
    
    @IBAction func chooseTime(_ sender: UIButton) {
        chooseTimeForItem(sender: sender)
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

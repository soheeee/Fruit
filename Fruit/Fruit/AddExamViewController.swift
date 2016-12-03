//
//  AddExamViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

class AddExamViewController: ItemViewController {
    
    var exam = Exam()
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var subject: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        memo.inputAccessoryView = toolBar
        categories += ["중간고사", "기말고사", "퀴즈", "기타"]
        collectionViewForItem = collectionView
    }
    
    @IBAction func viewClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addExam(_ sender: Any) {
        
        exam.subFull = subject.text!
        exam.memo = memo.text!
        
        if(exam.memo != ""){
            
            self.dismiss(animated: false, completion: nil)
            
        }else{
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

//
//  AddExamViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

//extension UIToolbar {
//    func ToolbarPiker(mySelect: Selector) -> UIToolbar {
//        
//        let toolBar = UIToolbar()
//        
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = blushTwo
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done ", style: UIBarButtonItemStyle.done, target: self, action: mySelect)
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        
//        toolBar.setItems([spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        
//        return toolBar
//    }
//}

class AddExamViewController: UIViewController {
   
    var exam = Exam()
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var subject: UITextView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var memo: UITextField!
    

    var selectRow = 0
    var Array = ["중간고사", "기말고사", "퀴즈", "기타"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        date.inputAccessoryView = toolBar
        time.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
        
        setBackgroundColor()
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
   
    @IBAction func addExam(_ sender: Any) {
        
        exam.memo = memo.text!
        
        if(exam.memo != nil){
            
            self.dismiss(animated: false, completion: nil)
            
        }
        
        
    }
    @IBAction func chooseExamType(_ sender: Any) {
        
        let typePicker = ActionSheetMultipleStringPicker(title: "시험종류", rows: [
            Array
            ], initialSelection: [0], doneBlock: {
                picker, values, indexes in
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                
                let str = values?.description
                let index = Int(String((str?[(str?.index((str?.startIndex)!, offsetBy: 1))!])!))
                
                self.type.text = self.Array[index!]
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        typePicker?.setTextColor(brownishGrey)
        typePicker?.pickerBackgroundColor = UIColor.white
        typePicker?.toolbarBackgroundColor = UIColor.white
        typePicker?.toolbarButtonsColor = blushTwo
        typePicker?.show()
        
    }
    @IBAction func addSubject(_ sender: Any) {
        
        let alert = UIAlertController(title: "과목 추가", message: "과목명과 줄임말을 입력해주세요", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "전체 과목명"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "최대 3글자 이내"
        }
        
        alert.view.tintColor = blushTwo
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.subject.text = alert?.textFields![1].text
//            print("Text field: \(textField?.text)")
        }))
        
        self.present(alert, animated: true, completion: nil)
//        subject.text = alert.textFields?[1].text
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = blushTwo
        
    }
    
    func setBackgroundColor(){
        
        let gradient = CAGradientLayer()
        let CGblushTwo:CGColor = blushTwo.cgColor
        let CGpalePeach:CGColor = palePeach.cgColor
        gradient.colors = [CGblushTwo, CGpalePeach]
        gradient.frame = view.bounds
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
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

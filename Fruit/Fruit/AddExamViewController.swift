//
//  AddExamViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit



class AddExamViewController: UIViewController {
   
    var exam = Exam()
    @IBOutlet weak var type: UITextField!
//    @IBOutlet weak var subject: UITextView!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var subject: UITextField!

    var selectRow = 0
    var Array = ["중간고사", "기말고사", "퀴즈", "기타"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
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
        
        let typePicker = ActionSheetMultipleStringPicker(title: "시험종류", rows: [Array], initialSelection: [0], doneBlock: {
                picker, values, indexes in
                
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
        
        alert.addTextField { (textField) in textField.placeholder = "전체 과목명" }
        alert.addTextField { (textField) in textField.placeholder = "최대 3글자 이내" }
        
        alert.view.tintColor = blushTwo
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { [weak alert] (_) in
            self.subject.text = alert?.textFields![0].text
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        
        let datePicker = ActionSheetDatePicker(title: "날짜", datePickerMode: UIDatePickerMode.date
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -15)
                let dateStr = values.debugDescription[range]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateObj = dateFormatter.date(from: dateStr)
                
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                
                self.date.setTitle(dateFormatter.string(from: dateObj!), for: UIControlState.normal)
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        datePicker?.setTextColor(brownishGrey)
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.toolbarButtonsColor = blushTwo
        datePicker?.show()
        
    }

    @IBAction func chooseTime(_ sender: UIButton) {
        
        let timePicker = ActionSheetDatePicker(title: "시간", datePickerMode: UIDatePickerMode.time
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -6)
        
                let dateStr = values.debugDescription[range]
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var dateObj = dateFormatter.date(from: dateStr)
               
                dateObj = dateObj?.addingTimeInterval(9*60*60)
              
                
                dateFormatter.dateFormat = "h:mm a"
               
                
                self.time.setTitle(dateFormatter.string(from: dateObj!), for: UIControlState.normal)
                
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        timePicker?.setTextColor(brownishGrey)
        timePicker?.pickerBackgroundColor = UIColor.white
        timePicker?.toolbarBackgroundColor = UIColor.white
        timePicker?.toolbarButtonsColor = blushTwo
        timePicker?.show()
        
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

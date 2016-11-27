//
//  AddAssignmentViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

extension UIToolbar {
    func ToolbarPiker(mySelect: Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = blushTwo
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done ", style: UIBarButtonItemStyle.done, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

class AddAssignmentViewController: UIViewController {
    
    var assignment = Assignment()
    var Array = ["과제", "프로젝트", "팀플", "발표"]
    
    @IBOutlet var name : UITextField! = UITextField()
    @IBOutlet var memo : UITextField! = UITextField()
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet var category : UITextField! = UITextField()
    @IBOutlet weak var subject: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        name.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
        
        setBackgroundColor()
        
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
    
    @IBAction func chooseCategory(_ sender: Any){
        
        let categoryPicker = ActionSheetMultipleStringPicker(title: "카테고리", rows: [
            Array
            ], initialSelection: [0], doneBlock: {
                picker, values, indexes in
        
                let str = values?.description
                let index = Int(String((str?[(str?.index((str?.startIndex)!, offsetBy: 1))!])!))
                
                self.category.text = self.Array[index!]
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        categoryPicker?.setTextColor(brownishGrey)
        categoryPicker?.pickerBackgroundColor = UIColor.white
        categoryPicker?.toolbarBackgroundColor = UIColor.white
        categoryPicker?.toolbarButtonsColor = blushTwo
        categoryPicker?.show()
        
    }
    
    @IBAction func addAssignment(_ sender: Any) {
        
        assignment.name = name.text!
        assignment.memo = memo.text!
        
        if(assignment.name != nil && assignment.memo != nil){
            self.dismiss(animated: false, completion: nil)
        }
    }

    @IBAction func viewClose(_ sender: UIButton) {
         self.dismiss(animated: false, completion: nil)
    }
    
    func setBackgroundColor(){
        
        let gradient = CAGradientLayer()
        let CGblushTwo:CGColor = blushTwo.cgColor
        let CGpalePeach:CGColor = palePeach.cgColor
        gradient.colors = [CGblushTwo, CGpalePeach]
        gradient.frame = view.bounds
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    @IBAction func addSubjectPressed(sender: UIButton){
        
        let alert = UIAlertController(title: "과목 추가", message: "과목명과 줄임말을 입력해주세요", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "전체 과목명" }
        alert.addTextField { (textField) in textField.placeholder = "최대 3글자 이내" }
        
        alert.view.tintColor = blushTwo
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { [weak alert] (_) in
            self.subject.text = alert?.textFields![0].text
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = blushTwo
        
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        
        let datePicker = ActionSheetDatePicker(title: "마감날짜", datePickerMode: UIDatePickerMode.date
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -15)
                let dateStr = values.debugDescription[range]
                
                self.date.setTitle(dateStr, for: UIControlState.normal)
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        datePicker?.setTextColor(brownishGrey)
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.toolbarButtonsColor = blushTwo
        datePicker?.show()
        
    }
    
    @IBAction func chooseTime(_ sender: UIButton) {
        
        let timePicker = ActionSheetDatePicker(title: "마감시간", datePickerMode: UIDatePickerMode.time
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -6)
                let dateStr = values.debugDescription[range]
                
                self.time.setTitle(dateStr, for: UIControlState.normal)
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        timePicker?.setTextColor(brownishGrey)
        timePicker?.pickerBackgroundColor = UIColor.white
        timePicker?.toolbarBackgroundColor = UIColor.white
        timePicker?.toolbarButtonsColor = blushTwo
        timePicker?.show()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

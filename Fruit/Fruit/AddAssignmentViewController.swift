//
//  AddAssignmentViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController{
    
    var assignment = Assignment()
    var Array = ["과제", "프로젝트", "팀플", "발표"]
    
    @IBOutlet var name : UITextField! = UITextField()
    @IBOutlet var memo : UITextField! = UITextField()
    @IBOutlet var category : UITextField! = UITextField()
    @IBOutlet weak var subject: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackgroundColor()
        
    }
    
    @IBAction func chooseCategory(_ sender: Any){
        
        let categoryPicker = ActionSheetMultipleStringPicker(title: "카테고리", rows: [
            Array
            ], initialSelection: [0], doneBlock: {
                picker, values, indexes in
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                
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
//            print("Text field: \(textField?.text)")]
            self.subject.text = alert?.textFields![1].text
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = blushTwo
        
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

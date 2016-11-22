//
//  AddExamViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

class AddExamViewController: UIViewController {
   
    @IBOutlet weak var type: UITextField!

    var selectRow = 0
    var Array = ["중간고사", "기말고사", "퀴즈", "기타"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
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
        
        typePicker?.setTextColor(UIColor(red: CGFloat(100)/255, green: CGFloat(98)/255, blue: CGFloat(98)/255, alpha: 1.0))
        typePicker?.pickerBackgroundColor = UIColor.white
        typePicker?.toolbarBackgroundColor = UIColor.white
        typePicker?.toolbarButtonsColor = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        typePicker?.show()
        
    }

    @IBAction func addSubject(_ sender: Any) {
        
        let alert = UIAlertController(title: "과목 추가", message: "과목명과 줄임말을 입력해주세요", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "전체 과목명"
            textField.preservesSuperviewLayoutMargins = false
            textField.textInputView.layoutMargins = UIEdgeInsets(top:20,left:0,bottom:0,right:0)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "최대 3글자 이내"
        }
        
        alert.view.tintColor = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        
    }
    
    func setBackgroundColor(){
        
        let gradient = CAGradientLayer()
        let blushTwo:CGColor = UIColor(red:0.96, green:0.57, blue:0.57, alpha:1.0).cgColor
        let palePeach:CGColor = UIColor(red:1.0, green:0.90, blue:192.0/255.0, alpha:1.0).cgColor
        gradient.colors = [blushTwo, palePeach]
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

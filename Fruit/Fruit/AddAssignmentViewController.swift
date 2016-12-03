//
//  AddAssignmentViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class AddAssignmentViewController: ItemViewController {
    @IBOutlet var name : UITextField! = UITextField()
    @IBOutlet var memo : UITextField! = UITextField()
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet var category : UITextField! = UITextField()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subject: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        name.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
        categories += ["과제", "프로젝트", "팀플", "발표"]
        collectionViewForItem = collectionView
    }
    
    @IBAction func chooseCategory(_ sender: Any){
        chooseCategoryForItem(title: "카테고리", sender: sender, category: self.category)
    }
    
    @IBAction func addAssignment(_ sender: Any) {
        if(name.text != "") {
            let assignment = Assignment(id: 1, time: dateVar as NSDate, name: name.text!, subFull: category.text!, subShort: category.text!, memo: memo.text!)
            
            itemList.insertItem(item: assignment)
            
            self.dismiss(animated: true, completion: nil)
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

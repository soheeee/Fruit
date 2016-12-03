//
//  AddAssignmentViewController.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 19..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class AddAssignmentViewController: ItemViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var Array = ["과제", "프로젝트", "팀플", "발표"]
    
    @IBOutlet var name : UITextField! = UITextField()
    @IBOutlet var memo : UITextField! = UITextField()
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet var category : UITextField! = UITextField()
    @IBOutlet weak var collectionView: UICollectionView!
    
//    @IBOutlet weak var subject: UITextView!
    
    @IBOutlet weak var subject: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        name.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
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
    
    let reuseIdentifier = "subcell" // also enter this string as the cell identifier in the storyboard
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SubjectCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.sublabel.text = subjects[indexPath.item]
        
        cell.delete.layer.setValue(indexPath.row, forKey: "index")
        cell.delete.addTarget(self, action: #selector(self.deleteSubject), for: UIControlEvents.touchUpInside)
        
        //cellColor
        let cellColor = indexPath.item % 4
        switch(cellColor){
        case 0:
            cell.circle.backgroundColor = lightPeach
            break
        case 1:
            cell.circle.backgroundColor = paleSalmon
            break
        case 2:
            cell.circle.backgroundColor = blush
            break
        case 3:
            cell.circle.backgroundColor = blushTwo
            break
        default:
            cell.circle.backgroundColor = warmGrey
            break
        }
        
        return cell
    }
    
    func deleteSubject(sender: UIButton){
        
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        subjects.remove(at: i)
        collectionView.reloadData()
        
    }
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        
        print("You selected cell #\(indexPath.item)!")
    }*/
    
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

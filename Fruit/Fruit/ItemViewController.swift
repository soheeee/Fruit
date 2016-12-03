//
//  ItemViewController.swift
//  Fruit
//
//  Created by Jin Park on 03/12/2016.
//  Copyright © 2016 소희. All rights reserved.
//

import Foundation

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

class ItemViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var dateVar = Date()
    var categories : [String] = []
    var collectionViewForItem: UICollectionView?
    var subjectForItem: UITextField?
    
    override func viewDidLoad() {
        // Set default date to today 23:59:59
        setTime(hour: 23, minute: 59, second: 59)
        
        setBackgroundColor()
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
    
    func setBackgroundColor(){
        let gradient = CAGradientLayer()
        let CGblushTwo:CGColor = blushTwo.cgColor
        let CGpalePeach:CGColor = palePeach.cgColor
        gradient.colors = [CGblushTwo, CGpalePeach]
        gradient.frame = view.bounds
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func addSubjectForItem(subject: UITextField) {
        let alert = UIAlertController(title: "과목 추가", message: "과목명과 줄임말을 입력해주세요", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "전체 과목명" }
        alert.addTextField { (textField) in textField.placeholder = "최대 3글자 이내" }
        
        alert.view.tintColor = blushTwo
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { [weak alert] (_) in
            subject.text = alert?.textFields![0].text
            // TODO: Save short name, too
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func chooseCategoryForItem(title: String, sender: Any, category: UITextField) {
        let categoryPicker = ActionSheetMultipleStringPicker(title: title, rows: [
            categories
            ], initialSelection: [0], doneBlock: {
                picker, values, indexes in
                
                let str = values?.description
                let index = Int(String((str?[(str?.index((str?.startIndex)!, offsetBy: 1))!])!))
                
                category.text = self.categories[index!]
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        categoryPicker?.setTextColor(brownishGrey)
        categoryPicker?.pickerBackgroundColor = UIColor.white
        categoryPicker?.toolbarBackgroundColor = UIColor.white
        categoryPicker?.toolbarButtonsColor = blushTwo
        categoryPicker?.show()
    }
    
    func chooseDateForItem(sender: UIButton){
        let datePicker = ActionSheetDatePicker(title: "마감날짜", datePickerMode: UIDatePickerMode.date
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -16)
                let dateStr = values.debugDescription[range]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateObj = dateFormatter.date(from: dateStr)
                
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                
                sender.setTitle(dateFormatter.string(from: dateObj!), for: UIControlState.normal)
                
                self.setDate(dateObj: dateObj!)
                
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        datePicker?.setTextColor(brownishGrey)
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.toolbarButtonsColor = blushTwo
        datePicker?.show()
    }
    
    func chooseTimeForItem(sender: UIButton){
        let timePicker = ActionSheetDatePicker(title: "마감시간", datePickerMode: UIDatePickerMode.time
            , selectedDate: Date.init(), doneBlock: {picker, values, indexes in
                
                let str = values.debugDescription.characters
                let range = str.index(str.startIndex, offsetBy: 9)..<str.index(str.endIndex, offsetBy: -6)
                let dateStr = values.debugDescription[range]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var dateObj = dateFormatter.date(from: dateStr)
                dateObj = dateObj?.addingTimeInterval(9*60*60)
                
                dateFormatter.dateFormat = "h:mm a"
                
                sender.setTitle(dateFormatter.string(from: dateObj!), for: UIControlState.normal)
                
                self.setTime(timeObj: dateObj!)
                
                return}, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
        
        timePicker?.setTextColor(brownishGrey)
        timePicker?.pickerBackgroundColor = UIColor.white
        timePicker?.toolbarBackgroundColor = UIColor.white
        timePicker?.toolbarButtonsColor = blushTwo
        timePicker?.show()
    }
    
    func setDate(dateObj:Date) {
        let cal = Calendar(identifier: .gregorian)
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateObj)
        let year = components.year
        let month = components.month
        let day = components.day
        setDate(year: year!, month: month!, day: day!)
    }
    
    func setDate(year:Int, month:Int, day:Int) {
        let cal = Calendar(identifier: .gregorian)
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateVar)
        components.year = year
        components.month = month
        components.day = day
        dateVar = cal.date(from: components)!
    }
    
    func setTime(timeObj:Date) {
        let cal = Calendar(identifier: .gregorian)
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: timeObj)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        setTime(hour: hour!, minute: minute!, second: second!)
    }
    
    func setTime(hour:Int, minute:Int, second:Int) {
        let cal = Calendar(identifier: .gregorian)
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateVar)
        components.hour = hour
        components.minute = minute
        components.second = second
        dateVar = cal.date(from: components)!
    }
    
    // MARK: - UICollectionViewDataSource protocol
    let reuseIdentifier = "subcell" // also enter this string as the cell identifier in the storyboard
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectList.subjects.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SubjectCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.sublabel.text = subjectList.subjects[indexPath.item].short
        
        cell.delete.layer.setValue(indexPath.row, forKey: "index")
        cell.delete.addTarget(self, action: #selector(self.deleteSubject), for: UIControlEvents.touchUpInside)
        
        cell.button.layer.setValue(indexPath.row, forKey: "index")
        cell.button.addTarget(self, action: #selector(self.selectSubject), for: .touchUpInside)
        
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
    
    func selectSubject(sender: UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        subjectForItem?.text = subjectList.subjects[i].name
    }
    
    func deleteSubject(sender: UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        if(subjectForItem?.text == subjectList.subjects[i].name) {
            subjectForItem?.text = ""
        }
        subjectList.deleteSubject(at: i)
        subjectList.subjects.remove(at: i)
        collectionViewForItem?.reloadData()
    }
}

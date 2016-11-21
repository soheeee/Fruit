//
//  MainTableviewController.swift
//  Fruit
//
//  Created by ohso on 2016. 11. 8..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class MainTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var startLocation:CGPoint!
    var lastLocation:CGPoint!
    var arrayItem:[Item] = itemList.items
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
//    @IBOutlet weak var todayAssignment: UITextView!
//    @IBOutlet weak var todayLeftCount: UITextView!
//    @IBOutlet weak var todayDate: UITextView!
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayLeftCount: UILabel!
    @IBAction func CreateDummy(_ sender: Any) {
        itemList.createDummy()
        refreshTable()
    }
    
    func setUpperText(){
//        todayAssignment.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
//        todayLeftCount.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
//        todayDate.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        
        todayLeftCount.layer.cornerRadius = todayLeftCount.frame.size.height/2
        todayLeftCount.clipsToBounds = false
        todayLeftCount.layer.shadowOpacity = 1
        todayLeftCount.layer.shadowOffset = CGSize(width: 2, height: 2)
        todayLeftCount.layer.shadowColor = UIColor(red: 238/255, green: 65/255, blue: 86/255, alpha: 0.5).cgColor
        line.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    
        
        let current = Date()
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: current)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = formatter.string(from: current) + getKoreanWeekday(day: weekDay)
        todayDate.text = dateString
        
        let attributedString = NSMutableAttributedString(string: todayDate.text!)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(-0.6), range: NSRange(location: 0, length: attributedString.length))
        todayDate.attributedText = attributedString
    }
    
    func getKoreanWeekday(day:Int)->String{
        var koreanWeekDay:String
        switch day {
        case 1:
            koreanWeekDay = "일"
            break
        case 2:
            koreanWeekDay = "월"
            break
        case 3:
            koreanWeekDay = "화"
            break
        case 4:
            koreanWeekDay = "수"
            break
        case 5:
            koreanWeekDay = "목"
            break
        case 6:
            koreanWeekDay = "금"
            break
        case 7:
            koreanWeekDay = "토"
            break
        default:
            koreanWeekDay = "?"
        }
        return " " + koreanWeekDay + "요일"
    }
    
    func setUpperViewLayer() {        
        let gradient = CAGradientLayer()
        gradient.frame = upperView.frame
        
        let blushTwo:CGColor = UIColor(red:0.96, green:0.57, blue:0.57, alpha:1.0).cgColor
        let palePeach:CGColor = UIColor(red:1.0, green:0.90, blue:192.0/255.0, alpha:1.0).cgColor
        gradient.colors = [blushTwo, palePeach]
        
        upperView.layer.insertSublayer(gradient, at: 0)
    }
    
    func deleteCell(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print(indexPath.row)
                deleteItem(row: indexPath.row)
            }
        }
    }
    
    override func viewDidLoad() {
        self.setUpperViewLayer()
        self.setUpperText()
        self.refreshTable()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.deleteCell))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        self.tableView.isScrollEnabled = false
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panedView))
        self.view.addGestureRecognizer(pan)
        
    }
    
    func panedView(sender: UIPanGestureRecognizer){
        if arrayItem.count == 0 {
            return
        }
        if sender.state == UIGestureRecognizerState.began {
            startLocation = sender.location(in: self.view)
        } else if sender.state == UIGestureRecognizerState.ended {
            // Check Velocity            
            let vel = -sender.velocity(in: self.view).y
            var first:Int = 0
            let cellHeight = tableView.rowHeight
            
            // Get the first visible cell's index
            if tableView.visibleCells.count != 0 {
                first = (tableView.indexPathsForVisibleRows?.first?.row)!
                if tableView.contentOffset.y.truncatingRemainder(dividingBy: cellHeight) > cellHeight/2 {
                    first += 1
                }
            }
            
            // Calculate how many rows to move.
            var move = Int(vel/cellHeight)/2+first
            if move < 0 {
                move = 0
            } else if move > arrayItem.count - 1 {
                move = arrayItem.count - 1
            }
            
            // Let the table scroll
            let moveIndex = IndexPath(item: move, section: 0)
            tableView.scrollToRow(at: moveIndex, at: .top, animated: true)
            lastLocation = nil
        } else if sender.state == UIGestureRecognizerState.changed{
            // Follow scroll
            if lastLocation == nil {
                lastLocation = startLocation
            }
            let currentLocation = sender.location(in: self.view)
            let dy = currentLocation.y - lastLocation.y
            tableView.contentOffset = CGPoint(x: 0, y: tableView.contentOffset.y - dy)
            lastLocation = currentLocation
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! MainTableViewCell
        let item : Item = arrayItem[indexPath.row]
        
        // Time
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        let timeString = formatter.string(from: item.time as Date)
        
        if indexPath.row % 2 == 0 {
            // Right
            cell.title.text = ""
            cell.time.text = ""
            cell.rightTitle.text = item.title
            cell.rightTime.text = item.subShort + " - " + timeString
        } else {
            // Left
            cell.title.text = item.title
            cell.time.text = item.subShort + " - " + timeString
            cell.rightTitle.text = ""
            cell.rightTime.text = ""
        }        
        
        // Date
        formatter.dateFormat = "MM/dd"
        let dateString = formatter.string(from: item.time as Date)
        cell.date.text = dateString
        
        // Today
        let today = formatter.string(from: Date())
        if today == dateString {
            cell.today.alpha = 1
        } else {
            cell.today.alpha = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4
    }
    
    @IBAction func CreateItem(_ sender: Any) {
        itemList.createDummy()
        refreshTable()
    }
    
    func refreshTable() {
        arrayItem = itemList.getItemsFromNow()
        todayLeftCount.text = String(arrayItem.count) + "개 남았습니다"
        tableView.reloadData()
    }
    
    func deleteItem(row: Int) {
        let alert = UIAlertController(title: "항목 삭제", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        
        alert.view.tintColor = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "삭제", style: .default){UIAlertAction in itemList.deleteItem(item: self.arrayItem[row])
            self.refreshTable()})
        
        self.present(alert, animated: true, completion: nil)
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        
        
    }
}

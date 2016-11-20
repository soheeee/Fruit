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
    
    @IBOutlet weak var todayAssignment: UITextView!
    @IBOutlet weak var todayLeftCount: UITextView!
    @IBOutlet weak var todayDate: UITextView!
    
    @IBAction func CreateDummy(_ sender: Any) {
        itemList.createDummy()
        refreshTable()
    }
    
    func setUpperText(){
        todayAssignment.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        todayLeftCount.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        todayDate.textContainerInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        
        todayLeftCount.layer.cornerRadius = todayLeftCount.frame.size.height/2
        todayLeftCount.clipsToBounds = false
        todayLeftCount.layer.shadowOpacity = 1
        todayLeftCount.layer.shadowOffset = CGSize(width: 2, height: 2)
        todayLeftCount.layer.shadowColor = UIColor(red: 238/255, green: 65/255, blue: 86/255, alpha: 0.5).cgColor
        
        let current = Date()
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: current)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = formatter.string(from: current) + getKoreanWeekday(day: weekDay)
        todayDate.text = dateString
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
    
    override func viewDidLoad() {
        self.setUpperViewLayer()
        self.setUpperText()
        self.refreshTable()
        
        self.tableView.isScrollEnabled = false;
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panedView))
        self.view.addGestureRecognizer(pan)
        
    }
    
    func panedView(sender: UIPanGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
            startLocation = sender.location(in: self.view)
        } else if sender.state == UIGestureRecognizerState.ended {
            // TODO: Check Velocity
            let stopLocation = sender.location(in: self.view)
            let dy = lastLocation.y - stopLocation.y
            print("swipe distance : ", startLocation.y - stopLocation.y)
            
            let first:Int = (tableView.indexPathsForVisibleRows?.first?.row)!
            
            var move:Int = Int(dy/100) + first
            
            if move < 0 {
                move = 0
            } else if move > arrayItem.count - 1 {
                move = arrayItem.count - 1
            }
            
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
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let item : Item = arrayItem[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.time.description
        
        return cell
    }
    
    @IBAction func CreateItem(_ sender: Any) {
        itemList.createDummy()
        refreshTable()
    }
    
    func refreshTable() {
        arrayItem = itemList.items
        todayLeftCount.text = String(arrayItem.count) + "개 남았습니다"
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(row: indexPath.row)
        }
    }
    
    func deleteItem(row: Int) {
        itemList.deleteItem(at: row)
        refreshTable()
    }
    
}

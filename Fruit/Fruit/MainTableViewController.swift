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
    var arrayItem:[Item] = []
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayTitle: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayLeftCount: UILabel!
    @IBAction func CreateDummy(_ sender: Any) {
        itemList.createDummy()
        
        refreshTable()
    }
    
    func setUpperText(){
        todayLeftCount.layer.cornerRadius = todayLeftCount.frame.size.height/2
        todayLeftCount.clipsToBounds = false
        todayLeftCount.layer.shadowOpacity = 1
        todayLeftCount.layer.shadowOffset = CGSize(width: 2, height: 2)
        todayLeftCount.layer.shadowColor = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 0.5).cgColor
        line.backgroundColor = white
        
        
        let current = Date()
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: current)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = formatter.string(from: current) + getKoreanWeekday(day: weekDay)
        todayDate.text = dateString
        
        var attributedString = NSMutableAttributedString(string: todayDate.text!)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(-0.6), range: NSRange(location: 0, length: attributedString.length))
        todayDate.attributedText = attributedString
        
        attributedString = NSMutableAttributedString(string: todayTitle.text!)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(-0.6), range: NSRange(location: 0, length: attributedString.length))
        todayTitle.attributedText = attributedString
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
        
        let CGblushTwo:CGColor = blushTwo.cgColor
        let CGpalePeach:CGColor = palePeach.cgColor
        gradient.colors = [CGblushTwo, CGpalePeach]
        
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
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.deleteCell))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        self.tableView.isScrollEnabled = false
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panedView))
        self.view.addGestureRecognizer(pan)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshTable()
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
            var move = Int(vel/cellHeight)/7+first
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
        let itemname: String = item.title
        
        // Time
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        let timeString = formatter.string(from: item.time as Date)
        
        if indexPath.row % 2 == 0 {
            // Right
            cell.title.text = ""
            cell.time.text = ""
            cell.rightTitle.text = limitedTitleLength(title: itemname)
            cell.rightTime.text = item.subject.short + " - " + timeString
        } else {
            // Left
            cell.title.text = limitedTitleLength(title: itemname)
            cell.time.text = item.subject.short + " - " + timeString
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrayItem[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        if item.id == -1 {
            print("Dummy")
        } else if item.id == 0 {
            print("Assignment")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddAssignment") as! AddAssignmentViewController
            vc.isEditmode = true
            vc.assignmentToEdit = item as? Assignment
            self.navigationController?.present(vc, animated: true, completion: nil)
        } else if item.id == 1 {
            print("Exam")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddExam") as! AddExamViewController
            vc.isEditmode = true
            vc.examToEdit = item as? Exam
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func CreateItem(_ sender: Any) {
        itemList.createDummy()
        refreshTable()
    }
    
    func refreshTable() {
        arrayItem = itemList.getItemsFromNow()
        arrayItem = arrayItem.sorted(by: {$0.time.compare($1.time as Date) == ComparisonResult.orderedAscending})
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        let today = formatter.string(from:Date())
        var dateString:String
        var assignmentDue:Int = 0
        
        if(arrayItem.count > 0) {
            for i in 0 ... arrayItem.count - 1{
                dateString = formatter.string(from: arrayItem[i].time as Date)
                
                if(today == dateString){
                    assignmentDue += 1
                }
            }
        }
        
        todayLeftCount.text = String(assignmentDue) + "개 남았습니다"
        tableView.reloadData()
    }
    
    func deleteItem(row: Int) {
        let alert = UIAlertController(title: "항목 변경", message: "원하는 항목 선택햐주세요", preferredStyle: .alert)
        
        alert.view.tintColor = blushTwo
        
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "공유", style: .default){UIAlertAction in self.share(row: row)})
        alert.addAction(UIAlertAction(title: "삭제", style: .default){UIAlertAction in itemList.deleteItem(item: self.arrayItem[row])
            self.refreshTable()})
        
        self.present(alert, animated: true, completion: nil)
        
        // Necessary to apply tint on iOS 9
        alert.view.tintColor = blushTwo
    }
    
    func share(row: Int) {
        print("share")
        
        if KOAppCall.canOpenKakaoTalkAppLink() {
            KOAppCall.openKakaoTalkAppLink(dummyLinkObject(row: row))
        } else {
            print("Cannot open Kakaotalk")
        }
    }
    
    func dummyLinkObject(row:Int) -> [KakaoTalkLinkObject] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 a hh시 mm분"
        let timeString = formatter.string(from: self.arrayItem[row].time as Date)
        
        let label = KakaoTalkLinkObject.createLabel("과제 알림입니다.\n" +
            "과제명: " + (self.arrayItem[row].title).description +
            "\n과목명: " + (self.arrayItem[row].subject.name) +
            "\n마감: " + timeString)
        
        let image = KakaoTalkLinkObject.createImage("https://developers.kakao.com/assets/img/link_sample.jpg", width: 138, height: 80)
        
        let webLink = KakaoTalkLinkObject.createWebLink("과제 * 일정 관리 Fruit", url: "https://projectintheclass.github.io/Fruit/")

        
        let androidAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.android, devicetype: KakaoTalkLinkActionDeviceType.phone, execparam: ["test1" : "test1", "test2" : "test2"])
        let iphoneAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.IOS, devicetype: KakaoTalkLinkActionDeviceType.phone, execparam: ["test1" : "test1", "test2" : "test2"])
        let ipadAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.IOS, devicetype: KakaoTalkLinkActionDeviceType.pad, execparam: ["id" : "1", "name" : "test2", "subject":"", "date" :"" , "memo" : ""])
        let appLink = KakaoTalkLinkObject.createAppButton("Fruit 보러가기", actions: [androidAppAction!, iphoneAppAction!, ipadAppAction!])
        
        
        return [image!, label!, webLink!, appLink!]
    }
    
    //limiting title length
    func limitedTitleLength(title: String) -> String{
        
        if(title.characters.count <= 8){
            
            return title
            
        }else{
            
            let start = title.index(title.startIndex, offsetBy: 0)
            let end = title.index(title.startIndex, offsetBy: 8)
            let range = start..<end
            
            return title.substring(with: range) + "..."
            
        }
    }
}

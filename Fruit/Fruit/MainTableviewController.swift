//
//  MainTableviewController.swift
//  Fruit
//
//  Created by ohso on 2016. 11. 8..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class MainTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var arrayItem:[Item] = itemList.items
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    func setUpperViewLayer() {        
        let gradient = CAGradientLayer()
        gradient.frame = upperView.frame
        
        let blushTwo:CGColor = UIColor(red:0.96, green:0.57, blue:0.57, alpha:1.0).cgColor
        let palePeach:CGColor = UIColor(red:1.0, green:0.90, blue:192.0/255.0, alpha:1.0).cgColor
        gradient.colors = [blushTwo, palePeach]
        
        upperView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLoad() {
        //        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -220, 0);
        //        self.tableView.contentInset.top = 220
        self.setUpperViewLayer()
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

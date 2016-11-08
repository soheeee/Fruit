//
//  MainTableviewController.swift
//  Fruit
//
//  Created by ohso on 2016. 11. 8..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class MainTableViewController: UITableViewController{
    
    let arrayWorks:[String] = ["work"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWorks.count+100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
//        let work : String = arrayWorks[indexPath.row]
        
        cell.textLabel?.text = arrayWorks[0]
        cell.detailTextLabel?.text = arrayWorks[0] + " work"
        
        return cell
    }
    
}

//
//  MainTableviewController.swift
//  Fruit
//
//  Created by ohso on 2016. 11. 8..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit


class MainTableViewController: UITableViewController{
    
    var arrayItem:[Item] = itemList.items
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
		
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
}

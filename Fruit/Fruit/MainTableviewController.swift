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
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			deleteItem(row: indexPath.row)
		}
	}
	
	func deleteItem(row: Int) {
		itemList.deleteItem(at: row)
		refreshTable()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		CreateFloatingButton()
	}
	
	func CreateFloatingButton() {
		let fab = KCFloatingActionButton()
		fab.addItem("과제추가", icon:UIImage(named:"assignment")!, handler: {item in
			let alert = UIAlertController(title: "과제추가", message: "과제를 추가한다.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "네 알겠습니다", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			fab.close()
		})
		fab.addItem("시험추가", icon:UIImage(named:"exam")!, handler: {item in
			let alert = UIAlertController(title: "시험추가", message: "시험을 추가한다.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "네 알겠습니다", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			fab.close()
		})
		self.view.addSubview(fab)
	}
}

//
//  SubjectCollectionViewCell.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 29..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

var subjects = ["컴네", "데베시", "융소", "객지", "5", "6", "7", "8", "9", "10"]

class SubjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var delete: UIButton!
  
}

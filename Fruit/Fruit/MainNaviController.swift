//
//  MainNaviController.swift
//  Fruit
//
//  Created by ohso on 2016. 11. 16..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit
import Foundation

class MainNaviController : UINavigationController {
    
    var navBar: UINavigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarToTheView()
        // Do any additional setup after loading the view.
        self.title = "test test"
        CreateFloatingButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    func setNavBarToTheView() {
        self.navBar.frame = CGRect(x: 0, y: 0, width: 375, height: 220)
        let gradient = CAGradientLayer()
//        let sizeLength = UIScreen.main.bounds.size.height * 2
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: 375, height: 220)
        gradient.frame = defaultNavigationBarFrame
//        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        let blushTwo:CGColor = UIColor(red:0.96, green:0.57, blue:0.57, alpha:1.0).cgColor
        let palePeach:CGColor = UIColor(red:1.0, green:0.90, blue:192.0/255.0, alpha:1.0).cgColor
        
        gradient.colors = [blushTwo, palePeach]
        UINavigationBar.appearance().setBackgroundImage(self.image(fromLayer: gradient), for: .default)
                //self.navBar.backgroundColor = (blushTwo)
        self.view.addSubview(navBar)
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
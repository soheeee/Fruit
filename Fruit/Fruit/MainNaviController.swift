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
        
        
        let SCREEN_SIZE = UIScreen.main.bounds.size
        self.navBar.frame = CGRect(x: 0, y: 0, width: SCREEN_SIZE.width, height: SCREEN_SIZE.height/3)
        
        let gradient = CAGradientLayer()
        let defaultNavigationBarFrame = navBar.frame
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
        
        let fab = KCFloatingActionButton(image: UIImage(named: "error")!)
        
        fab.addItem("과제추가", icon:UIImage(named:"assignment")!, color: UIColor(red: CGFloat(250)/255, green: CGFloat(190)/255, blue: CGFloat(170)/255, alpha: 1.0),handler: {item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddAssignment") as! AddAssignmentViewController
            self.present(vc, animated: true, completion: nil)
            fab.close()
        })
        
        fab.addItem("시험추가", icon:UIImage(named:"exam")!, color: UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0),  handler: {item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddExam") as! AddExamViewController
            self.present(vc, animated: true, completion: nil)
            fab.close()
        })
        
        self.view.addSubview(fab)
    }
}

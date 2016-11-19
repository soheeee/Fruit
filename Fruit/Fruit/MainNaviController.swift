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
    
    var upperView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CreateFloatingButton()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
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
    
    func CreateFloatingButton() {
        
        let fab = KCFloatingActionButton(image: UIImage(named: "main_add")!)
        
        fab.addItem("과제추가", icon:UIImage(named:"book")!, color: UIColor(red: CGFloat(250)/255, green: CGFloat(190)/255, blue: CGFloat(170)/255, alpha: 1.0),handler: {item in
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

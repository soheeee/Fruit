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
        
        fab.addItem("과제추가", icon:UIImage(named:"book")!, color: paleSalmon, handler: {item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddAssignment") as! AddAssignmentViewController
            self.present(vc, animated: true, completion: nil)
            fab.close()
        })
        
        fab.addItem("시험추가", icon:UIImage(named:"exam")!, color: blushTwo, handler: {item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddExam") as! AddExamViewController
            self.present(vc, animated: true, completion: nil)
            fab.close()
        })
        
        self.view.addSubview(fab)
    }
}

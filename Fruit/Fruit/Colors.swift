//
//  Colors.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 22..
//  Copyright © 2016년 소희. All rights reserved.
//

import Foundation

struct Theme{
    static let availableThemes = ["Peach", "Mango", "Grape", "Blueberry"]
    static var defaults = UserDefaults.standard
    static func loadTheme(name: String){
            if name == "Peach"		{  Peach() }
            else if name == "Mango"		{  Mango() }
            else if name == "Blueberry"	{  Blueberry() }
            else if name == "Grape"		{  Grape() }
            else {defaults.set("Peach", forKey: "Theme")}
    }
    static var letter_light = UIColor(red: CGFloat(160)/255, green: CGFloat(160)/255, blue: CGFloat(160)/255, alpha: 1.0)
    static var letter_dark = UIColor(red: CGFloat(100)/255, green: CGFloat(98)/255, blue: CGFloat(98)/255, alpha: 1.0)
    static var main0 = UIColor(red: CGFloat(255)/255, green: CGFloat(231)/255, blue: CGFloat(192)/255, alpha: 1.0)
    static var main1 = UIColor(red: CGFloat(254)/255, green: CGFloat(222)/255, blue: CGFloat(187)/255, alpha: 1.0)
    static var main2 = UIColor(red: CGFloat(250)/255, green: CGFloat(190)/255, blue: CGFloat(170)/255, alpha: 1.0)
    static var main3 = UIColor(red: CGFloat(248)/255, green: CGFloat(175)/255, blue: CGFloat(162)/255, alpha: 1.0)
    static var main4 = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
    static var highlight = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 1.0)
    static var shadow = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 0.5)
    static var white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
    
    static func Peach(){
        letter_light = UIColor(red: CGFloat(160)/255, green: CGFloat(160)/255, blue: CGFloat(160)/255, alpha: 1.0)
        letter_dark = UIColor(red: CGFloat(100)/255, green: CGFloat(98)/255, blue: CGFloat(98)/255, alpha: 1.0)
        main0 = UIColor(red: CGFloat(255)/255, green: CGFloat(231)/255, blue: CGFloat(192)/255, alpha: 1.0)
        main1 = UIColor(red: CGFloat(250)/255, green: CGFloat(218)/255, blue: CGFloat(183)/255, alpha: 1.0)
        main2 = UIColor(red: CGFloat(250)/255, green: CGFloat(190)/255, blue: CGFloat(170)/255, alpha: 1.0)
        main3 = UIColor(red: CGFloat(248)/255, green: CGFloat(175)/255, blue: CGFloat(162)/255, alpha: 1.0)
        main4 = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
        highlight = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 1.0)
        shadow = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 0.5)
        white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
    }
    
    static func Mango(){
        letter_light = UIColor(red: CGFloat(154)/255, green: CGFloat(138)/255, blue: CGFloat(111)/255, alpha: 1.0)
        letter_dark = UIColor(red: CGFloat(54)/255, green: CGFloat(38)/255, blue: CGFloat(11)/255, alpha: 1.0)
        main0 = UIColor(red: CGFloat(222)/255, green: CGFloat(243)/255, blue: CGFloat(143)/255, alpha: 1.0)
        main1 = UIColor(red: CGFloat(205)/255, green: CGFloat(234)/255, blue: CGFloat(138)/255, alpha: 1.0)
        main2 = UIColor(red: CGFloat(250)/255, green: CGFloat(225)/255, blue: CGFloat(130)/255, alpha: 1.0)
        main3 = UIColor(red: CGFloat(248)/255, green: CGFloat(215)/255, blue: CGFloat(105)/255, alpha: 1.0)
        main4 = UIColor(red: CGFloat(245)/255, green: CGFloat(202)/255, blue: CGFloat(84)/255, alpha: 1.0)
        highlight = UIColor(red: CGFloat(157)/255, green: CGFloat(238)/255, blue: CGFloat(108)/255, alpha: 0.5)
        shadow = UIColor(red: CGFloat(157)/255, green: CGFloat(238)/255, blue: CGFloat(108)/255, alpha: 1.0)
        white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
    }
    
    static func Blueberry(){
        letter_light = UIColor(red: CGFloat(154)/255, green: CGFloat(138)/255, blue: CGFloat(111)/255, alpha: 1.0)
        letter_dark = UIColor(red: CGFloat(54)/255, green: CGFloat(38)/255, blue: CGFloat(11)/255, alpha: 1.0)
        main0 = UIColor(red: CGFloat(192)/255, green: CGFloat(231)/255, blue: CGFloat(255)/255, alpha: 1.0)
        main1 = UIColor(red: CGFloat(187)/255, green: CGFloat(222)/255, blue: CGFloat(254)/255, alpha: 1.0)
        main2 = UIColor(red: CGFloat(170)/255, green: CGFloat(190)/255, blue: CGFloat(250)/255, alpha: 1.0)
        main3 = UIColor(red: CGFloat(162)/255, green: CGFloat(175)/255, blue: CGFloat(248)/255, alpha: 1.0)
        main4 = UIColor(red: CGFloat(147)/255, green: CGFloat(147)/255, blue: CGFloat(245)/255, alpha: 1.0)
        highlight = UIColor(red: CGFloat(86)/255, green: CGFloat(65)/255, blue: CGFloat(238)/255, alpha: 0.5)
        shadow = UIColor(red: CGFloat(86)/255, green: CGFloat(65)/255, blue: CGFloat(238)/255, alpha: 1.0)
        white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
    }
    static func Grape(){
        letter_light = UIColor(red: CGFloat(154)/255, green: CGFloat(138)/255, blue: CGFloat(111)/255, alpha: 1.0)
        letter_dark = UIColor(red: CGFloat(54)/255, green: CGFloat(38)/255, blue: CGFloat(11)/255, alpha: 1.0)
        main0 = UIColor(red: CGFloat(231)/255, green: CGFloat(192)/255, blue: CGFloat(255)/255, alpha: 1.0)
        main1 = UIColor(red: CGFloat(222)/255, green: CGFloat(187)/255, blue: CGFloat(254)/255, alpha: 1.0)
        main2 = UIColor(red: CGFloat(190)/255, green: CGFloat(170)/255, blue: CGFloat(250)/255, alpha: 1.0)
        main3 = UIColor(red: CGFloat(175)/255, green: CGFloat(162)/255, blue: CGFloat(248)/255, alpha: 1.0)
        main4 = UIColor(red: CGFloat(147)/255, green: CGFloat(147)/255, blue: CGFloat(245)/255, alpha: 1.0)
        highlight = UIColor(red: CGFloat(65)/255, green: CGFloat(86)/255, blue: CGFloat(238)/255, alpha: 0.5)
        shadow = UIColor(red: CGFloat(65)/255, green: CGFloat(86)/255, blue: CGFloat(238)/255, alpha: 1.0)
        white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
    }
    
}
/*let paleSalmon = UIColor(red: CGFloat(250)/255, green: CGFloat(190)/255, blue: CGFloat(170)/255, alpha: 1.0)
let lightPeach = UIColor(red: CGFloat(254)/255, green: CGFloat(222)/255, blue: CGFloat(187)/255, alpha: 1.0)
let blush = UIColor(red: CGFloat(248)/255, green: CGFloat(175)/255, blue: CGFloat(162)/255, alpha: 1.0)
let blushTwo = UIColor(red: CGFloat(245)/255, green: CGFloat(147)/255, blue: CGFloat(147)/255, alpha: 1.0)
let warmGrey = UIColor(red: CGFloat(160)/255, green: CGFloat(160)/255, blue: CGFloat(160)/255, alpha: 1.0)
let brownishGrey = UIColor(red: CGFloat(100)/255, green: CGFloat(98)/255, blue: CGFloat(98)/255, alpha: 1.0)
let redPink = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 1.0)
let palePeach = UIColor(red: CGFloat(255)/255, green: CGFloat(231)/255, blue: CGFloat(192)/255, alpha: 1.0)
let redPink50 = UIColor(red: CGFloat(238)/255, green: CGFloat(65)/255, blue: CGFloat(86)/255, alpha: 0.5)
let white = UIColor(red: CGFloat(245)/255, green: CGFloat(245)/255, blue: CGFloat(245)/255, alpha: 1.0)
*/

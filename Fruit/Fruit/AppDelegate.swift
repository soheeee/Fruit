//
//  AppDelegate.swift
//  Fruit
//
//  Created by 소희 on 2016. 11. 1..
//  Copyright © 2016년 소희. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var reminderList: Array<Item> = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Reading the saved list of reminders from User Defaults.
        if let aList: AnyObject = UserDefaults.standard.object(forKey: "reminderList") as AnyObject? {
            let unArchivedList: AnyObject? = NSKeyedUnarchiver.unarchiveObject(with: aList as! Data) as AnyObject?
            self.reminderList = unArchivedList as! Array
        }
        // Calling our local method to register for local notifications.
        self.registerForLocalNotifications()
        
        // Handle any action if the user opens the application throught the notification. i.e., by clicking on the notification when the application is killed/ removed from background.
        if let aLaunchOptions = launchOptions { // Checking if there are any launch options.
            // Check if there are any local notification objects.
            if let notification = (aLaunchOptions as NSDictionary).object(forKey: "UIApplicationLaunchOptionsLocalNotificationKey") as? UILocalNotification {
                // Handle the notification action on opening. Like updating a table or showing an alert.
                UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        // Point for handling the local notification when the app is open.
        // Showing reminder details in an alertview
        UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        // Point for handling the local notification Action. Provided alongside creating the notification.
        if identifier == "ShowDetails" {
            // Showing reminder details in an alertview
            UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "OK").show()
//        } else if identifier == "Snooze" {
//            // Snooze the reminder for 5 minutes
//            notification.fireDate = Date().addingTimeInterval(60*5)
//            UIApplication.shared.scheduleLocalNotification(notification)
//        } else if identifier == "Confirm" {
            // Confirmed the reminder. Mark the reminder as complete maybe?
        }
        completionHandler()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let archivedReminderList = NSKeyedArchiver.archivedData(withRootObject: self.reminderList)
        UserDefaults.standard.set(archivedReminderList, forKey: "reminderList")

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // Reset the application badge to zero when the application as launched. The notification is viewed.
        if application.applicationIconBadgeNumber > 0 {
            application.applicationIconBadgeNumber = 0
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func registerForLocalNotifications() {
        // Specify the notification actions.
        let reminderActionConfirm = UIMutableUserNotificationAction()
        reminderActionConfirm.identifier = "Confirm"
        reminderActionConfirm.title = "Confirm"
        reminderActionConfirm.activationMode = UIUserNotificationActivationMode.background
        reminderActionConfirm.isDestructive = false
        reminderActionConfirm.isAuthenticationRequired = false
        
//        let reminderActionSnooze = UIMutableUserNotificationAction()
//        reminderActionSnooze.identifier = "Snooze"
//        reminderActionSnooze.title = "Snooze"
//        reminderActionSnooze.activationMode = UIUserNotificationActivationMode.background
//        reminderActionSnooze.isDestructive = true
//        reminderActionSnooze.isAuthenticationRequired = false
        
        // Create a category with the above actions
        let reminderCategory = UIMutableUserNotificationCategory()
        reminderCategory.identifier = "reminderCategory"
       reminderCategory.setActions([reminderActionConfirm], for: UIUserNotificationActionContext.default)
        reminderCategory.setActions([reminderActionConfirm], for: UIUserNotificationActionContext.minimal)
        
        // Register for notification: This will prompt for the user's consent to receive notifications from this app.
//        let setReminder:Set<UIUserNotificationCategory> = [reminderCategory]
        
        let notificationSettings = UIUserNotificationSettings(types: [.alert as UIUserNotificationType, .badge  as UIUserNotificationType, .sound  as UIUserNotificationType], categories: [reminderCategory])
    
        
        //*NOTE*
        // Registering UIUserNotificationSettings more than once results in previous settings being overwritten.
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }


}


//
//  AppDelegate.swift
//  Project-Swift
//
//  Created by Erico GT on 3/31/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    //
    var activityView:LoadingView? = nil
    var soundPlayer:SoundManager = SoundManager.init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NSLog("%@", ToolBox.applicationHelper_InstalationDataForSimulator())
        //
        activityView = LoadingView.new(owner: self)
    
        //self.registerNotifications()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    //MARK: - Public functions
    
    //NOTA1:toda vez que se recebe um push silencioso esse método é chamado. O app DEVE estar ABERTO (foreground ou background)
    //NOTA2:esse método é chamado sempre que uma notificação do IOS9 é recebida e o app está aberto (foreground ou background). Caso o app esteja fechado será chamado assim que a notificação for aberta
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        var not = userInfo["aps"] as! [String : AnyObject]
        
        //'content-available' sendo 1, a notificação pode ser iOS 9 ou iOS 10. 'content-available' sendo 0, sempre será iOS 9.
        if(not["content-available"] as? Int == 1) {
            
            if (self.systemVersionGreaterThanOrEqualTo(version: "10.0")){
                print("iOS 10 received push")
                
            }else{
                print("iOS 9 received push")
                
            }
            
            completionHandler(.newData)
        }
        else
        {
            print("iOS 9 received push")
            completionHandler(.noData)
            
        }
    }
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void)
    {
        completionHandler([.alert, .sound, .badge])
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void)
    {
        print(response.notification)
        //
        completionHandler()
    }
    
    //MARK: - Notifications:
    
//    func registerNotifications() {
//
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().requestAuthorization(options: [[.alert, .sound, .badge]], completionHandler: { (granted, error) in
//
//                if (granted) {
//
//                    UIApplication.shared.registerForRemoteNotifications()
//                    UNUserNotificationCenter.current().delegate = self
//
//                }else{
//                    // Handle Error
//                    //if let err:Error = error {
//                    // code here...
//                    //}
//                }
//            })
//        } else {
//
//            // Fallback on earlier versions:
//            let types:UIUserNotificationType = [.badge, .sound, .alert]
//            let settings = UIUserNotificationSettings.init(types: types, categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//
//        //UIApplication.shared.applicationIconBadgeNumber = 0
//
//    }
    
    public func updateTabBarController() {
        
        // Assign tab bar item with titles:
        let tabBarController:UITabBarController = self.window?.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar
        //
        let tabBarItem1 = tabBar.items?[0]
        let tabBarItem2 = tabBar.items?[1]
        let tabBarItem3 = tabBar.items?[2]
        let tabBarItem4 = tabBar.items?[3]
        let tabBarItem5 = tabBar.items?[4]
        //
        tabBarItem1?.title = "Main Menu"
        tabBarItem2?.title = "Tela A"
        tabBarItem3?.title = "Tela B"
        tabBarItem4?.title = "Tela C"
        tabBarItem5?.title = "Tela D"
        //
        tabBarItem1?.selectedImage = UIImage.init(named: "tabbar-icon-1")?.withRenderingMode(.alwaysOriginal)
        tabBarItem1?.image = UIImage.init(named: "tabbar-icon-1")
        tabBarItem2?.selectedImage = UIImage.init(named: "tabbar-icon-2")?.withRenderingMode(.alwaysOriginal)
        tabBarItem2?.image = UIImage.init(named: "tabbar-icon-2")
        tabBarItem3?.selectedImage = UIImage.init(named: "tabbar-icon-3")?.withRenderingMode(.alwaysOriginal)
        tabBarItem3?.image = UIImage.init(named: "tabbar-icon-3")
        tabBarItem4?.selectedImage = UIImage.init(named: "tabbar-icon-4")?.withRenderingMode(.alwaysOriginal)
        tabBarItem4?.image = UIImage.init(named: "tabbar-icon-4")
        tabBarItem5?.selectedImage = UIImage.init(named: "tabbar-icon-5")?.withRenderingMode(.alwaysOriginal)
        tabBarItem5?.image = UIImage.init(named: "tabbar-icon-5")
        
        
        // Change the tab bar background
        tabBar.backgroundImage = UIImage.init(named: "tabbar.png")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .tile) ?? UIImage.init()
        tabBar.shadowImage = UIImage.init()
        tabBar.backgroundColor = UIColor.clear
        //tabBar.selectionIndicatorImage = UIImage.init(named: "tabbar_selected.png") ?? UIImage.init()
        
        // Change the title color of tab bar items
        tabBarItem1?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        tabBarItem2?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        tabBarItem3?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        tabBarItem4?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        tabBarItem5?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        //
        tabBarItem1?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        tabBarItem2?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        tabBarItem3?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        tabBarItem4?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        tabBarItem5?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        
    }

    //MARK: - FAKE-FACTORY
    
    //MARK: - Métodos privados:
    private func systemVersionGreaterThanOrEqualTo(version:String) -> Bool
    {
        switch UIDevice.current.systemVersion.compare(version, options: .numeric) {
        case .orderedSame, .orderedDescending:
            return true
        case .orderedAscending:
            return false
        }
    }
    
}


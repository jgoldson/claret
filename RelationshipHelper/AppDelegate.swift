//
//  AppDelegate.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/19/21.
//

import Foundation
import NotificationCenter

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          // request for the permission
          let center = UNUserNotificationCenter.current()
          center.delegate = self
          center.getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .authorized  {
                print("permission granted")
            }
         })
         return true
    }

}

extension AppDelegate : UNUserNotificationCenterDelegate{
    
    /** Handle notification when the app is in background */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response:
    UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
  
        // handle the notification here
    }
    
    /** Handle notification when the app is in foreground */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
             willPresent notification: UNNotification,
             withCompletionHandler completionHandler:
                @escaping (UNNotificationPresentationOptions) -> Void) {
       
        // handle the notification here..
    }
}

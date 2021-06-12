//
//  NotificationHandler.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/8/21.
//

import Foundation
import UserNotifications

struct NotificationHandler{
    
    
    func setDailyNotification(notification : rDailyNotification) -> Date {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        //content.subtitle = notification.subtitle
        content.body = notification.body
        content.sound = UNNotificationSound.default
        
        //Set the interval at which the notification should play
        let gregorian = Calendar(identifier: .gregorian)
        let now = notification.date
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
                        
        // Change the time in your locale
        components.hour = notification.triggerHour
        components.minute = 0
        components.second = 0
        components.day! += 1
        //components.day = notification.triggerDay
        
        let date = gregorian.date(from: components)!
        
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger( dateMatching: triggerDaily, repeats: true)

        let request = UNNotificationRequest(identifier: notification.triggerIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            print("something went wrong: \(String(describing: error))")
          }
        }
        return date
        
    }
    func setWeeklyNotification(notification : rWeeklyNotification) -> Date {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        //content.subtitle = notification.subtitle
        content.body = notification.body
        content.sound = UNNotificationSound.default
        
        //Set the interval at which the notification should play
        let gregorian = Calendar(identifier: .gregorian)
        let now = notification.date
        var components = gregorian.dateComponents([.year, .month, .weekday, .day, .hour, .minute, .second], from: now)
                        
        // Change the time in your locale
        components.hour = notification.triggerHour
        components.minute = 0
        components.second = 0
        components.day! += 1

        
        let date = gregorian.date(from: components)!
        
        let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger( dateMatching: triggerWeekly, repeats: true)
        
        let request = UNNotificationRequest(identifier: notification.triggerIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            print("something went wrong: \(String(describing: error))")
          }
        }
        
        return date
    }
    func setMonthlyNotification(notification : rMonthlyNotification) -> Date {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        //content.subtitle = notification.subtitle
        content.body = notification.body
        content.sound = UNNotificationSound.default
        
        //Set the interval at which the notification should play
        let gregorian = Calendar(identifier: .gregorian)
        let now = notification.date
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
                        
        // Change the time in your locale
        components.hour = notification.triggerHour
        components.minute = 0
        components.second = 0
        components.day! += 2
        
        let date = gregorian.date(from: components)!
        
        let triggerMonthly = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger( dateMatching: triggerMonthly, repeats: true)
        
        let request = UNNotificationRequest(identifier: notification.triggerIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            print("something went wrong: \(String(describing: error))")
          }
        }
        
        return date
    }
    
    
}

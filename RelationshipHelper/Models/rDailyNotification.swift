//
//  Notification.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/8/21.
//

import Foundation

struct rDailyNotification {
    let triggerIdentifier: String
    let title : String
    //let subtitle: String
    let body: String
    let triggerHour: Int
    let date: Date
    
    /*init(i: String, t: String, s: String, th: Int){
        triggerIdentifier = i
        title = t
        subtitle = s
        triggerHour = th
    }
 */
}

struct rWeeklyNotification {
    let triggerIdentifier: String
    let title : String
    //let subtitle: String
    let body: String
    let triggerHour: Int
    let triggerDay: Int
    let date: Date
}

struct rMonthlyNotification {
    let triggerIdentifier: String
    let title : String
    //let subtitle: String
    let body: String
    let triggerHour: Int
    let triggerMonth: Int
    let date: Date
    
}

//
//  RelationshipHelperApp.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/7/21.
//

import SwiftUI

@main
struct RelationshipHelperApp: App {
    //@Environment(\.scenePhase) private var scenePhase
    
    
    @StateObject var notificationReceiver = NotificationReceiver()
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(ViewRouter())
            

        }
    }
}

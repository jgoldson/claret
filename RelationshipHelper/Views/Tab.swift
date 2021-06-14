//
//  TabView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 6/13/21.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
            
            SettingsView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}


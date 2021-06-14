//
//  MainView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 6/13/21.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 2
    var body: some View {
        TabView(selection:$selection) {

/*
            LoveScore()
                .tabItem {
                    Label("Love Score", systemImage: "suit.heart")
                }
                .tag(1)
 */
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

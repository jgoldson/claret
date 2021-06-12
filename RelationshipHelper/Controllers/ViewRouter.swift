//
//  ViewRouter.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/24/21.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: String

    init() {
        print("View router called")
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "firstLaunchDate")
            print("Launching onboarding View")
            currentPage = "onboardingView"
            
        } else {
            currentPage = "homeView"
            print("Launching HomeView")
        }
    }
    
    
    
}

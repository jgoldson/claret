//
//  MotherView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/24/21.
//

import SwiftUI

struct MotherView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            let currentPage = viewRouter.currentPage
            if currentPage == "onboardingView" {
                OnboardingView()
            }
            else if currentPage == "frequencyView"{
                FirstTimeFrequencyView()
            }
            else if currentPage == "homeView" {
                ContentView()
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

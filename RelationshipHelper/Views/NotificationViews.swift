//
//  NotificationViews.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/22/21.
//

import SwiftUI


struct NotificationsView: View {
    @Binding var appHeader : String
    @Binding var goalSubtitle: String
    @State var isHidden = true
    var title: String
    var suggestions: Array<String>
    var date: Date
    @State var clearDate: Date
    var id: String
    
    fileprivate func saveNewSuggestion(suggestion: String) {
        UserDefaults.standard.set(suggestion, forKey: "\(id)Suggestion")
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "\(id)LastSeen")
        UserDefaults.standard.synchronize()
    }
    fileprivate func getSuggestion() -> String {
        if let savedSuggestion = UserDefaults.standard.string(forKey: "\(id)Suggestion") {
            return savedSuggestion
        }else {
            return suggestions[Int.random(in: 0...(suggestions.count-1))]
        }
    }
    fileprivate func showSameSuggestion(timeInterval: Int) -> Bool{
        let lastSeenDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "\(id)LastSeen"))
        let delta = Date() - lastSeenDate
        if Int(delta) < timeInterval { //check if its been less than "timeInterval"" since user has seen suggestion
            return true
        }
        return false
    }
    fileprivate func shouldShowNotification(timeInterval: Int) -> Bool {
        //UserDefaults.standard.removeObject(forKey: "\(id)ClearDate") //Using for testing only

        if date <= Date() { //Check if notification was sent 1st time
            print("\(id) has clear date \(clearDate)")
            if Int(Date() - clearDate) > timeInterval { //Only proceed if its been more than a "timeInterval" (day, week, month)" since user cleared this notification
                
                return true
                
            }
        }
        return false
    }
    
    
    var body: some View {

        switch UserDefaults.standard.integer(forKey: "\(id)Frequency"){
        case 1: //Daily Frequency
            let timeInterval = 86400 // 1 day in seconds
            if shouldShowNotification(timeInterval: timeInterval){
                if showSameSuggestion(timeInterval: timeInterval) {
                    let suggestion = getSuggestion()
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                        }
                }
                //If its been more than 1 day, show a different suggestion
                else {
                    let suggestion = suggestions[Int.random(in: 0...(suggestions.count-1))]
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                            
                            saveNewSuggestion(suggestion: suggestion)
                        }
                }
            }
            
        case 2:
            let timeInterval = 604800 // 1 week in seconds
            if shouldShowNotification(timeInterval: timeInterval){
                if showSameSuggestion(timeInterval: timeInterval) {
                    let suggestion = getSuggestion()
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                        }
                }
                //If its been more than 1 day, show a different suggestion
                else {
                    let suggestion = suggestions[Int.random(in: 0...(suggestions.count-1))]
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                            saveNewSuggestion(suggestion: suggestion)
                        }
                }
            }
        case 3:
            let timeInterval = 2592000 // 1 month (30 days) in seconds
            if shouldShowNotification(timeInterval: timeInterval){
                if showSameSuggestion(timeInterval: timeInterval) {
                    let suggestion = getSuggestion()
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                        }
                }
                //If its been more than 1 day, show a different suggestion
                else {
                    let suggestion = suggestions[Int.random(in: 0...(suggestions.count-1))]
                    NotiLine(appHeader: $appHeader, clearDate: $clearDate, title: title, suggestion: suggestion, id: id)
                        .onAppear{appHeader = "New Goals"
                            goalSubtitle = "Express your affection through one of our suggestions or come up with your own"
                            saveNewSuggestion(suggestion: suggestion)
                        }
                }
            }
        default:
            HStack{}
        }
        
        
    }
    
}

struct NotiLine: View {
    @Binding var appHeader : String
    @Binding var clearDate: Date
    let title : String
    let suggestion : String
    let id : String
    
    
    var body: some View {
        var textColor =  Color(K.Color.BrandColor8)
        HStack{
            Text(title)
                .multilineTextAlignment(.center)
                .padding(.init(top: 0, leading: 8, bottom: 10, trailing: 8))
                .foregroundColor(Color(K.Color.BrandColor2))
                .font(.system(size: 16, weight: .semibold))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 110, maxHeight: 100, alignment: .center)
            

            
            VStack(alignment: .leading){
                Text("Here's a suggestion:")
                    
                    .multilineTextAlignment(.leading)
                    .foregroundColor(textColor)
                    .font(.system(size:14, weight: .semibold))
                
                Text(suggestion)
                    
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity )
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(textColor)
                    .padding(.bottom, 10)
                    
                
                
            }
            HStack{
                Button(action: {
                    print("Marked complete")
                    
                    UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "\(id)ClearDate")
                    UserDefaults.standard.synchronize()
                    var clearCount = UserDefaults.standard.integer(forKey: "\(id)ClearCount")
                    clearCount += 1
                    UserDefaults.standard.set(clearCount, forKey: "\(id)ClearCount")
                    UserDefaults.standard.synchronize()
                    //appHeader = "Cleared!"
                    clearDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "\(id)ClearDate"))
                    
                    print(clearDate)
                    
                }) {
                    Image(systemName: "checkmark.square")
                        .font(.system(size: 32.0))
                        .foregroundColor(Color(K.Color.BrandColor2))
                    
                }
                .padding(.trailing, 10)
            }
        }
    }
    
    
    
}


extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}

//
//  ContentView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/7/21.
//

import SwiftUI
import UserNotifications




struct ContentView: View {
    
    @State var toShowAlert : Bool = false
    @Environment(\.scenePhase) var scenePhase
    @State var appHeader = "No New Goals"
    @State var goalSubtitle = "Check back later, or adjust the frequency in the settings menu"
    @State var wakeupTime = 8
    @StateObject var notificationReceiver = NotificationReceiver()
    @State var loveScore = 100
    var notificationHandler = NotificationHandler()
    

    
    
    
    fileprivate func calculateScore() {
        let clearCount = UserDefaults.standard.integer(forKey: K.ClearCount.woa) +
            UserDefaults.standard.integer(forKey: K.ClearCount.qt) +
            UserDefaults.standard.integer(forKey: K.ClearCount.pt) +
            UserDefaults.standard.integer(forKey: K.ClearCount.rg) +
            UserDefaults.standard.integer(forKey: K.ClearCount.aos)
        
        let firstLaunchAppDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "firstLaunchDate"))
        let delta = Date() - firstLaunchAppDate
        var deltaInWeeks = floor(delta / 604800)
        if deltaInWeeks == 0 {
            deltaInWeeks = 1
        }
        let score = Double(clearCount) / deltaInWeeks
        if score > 3 {
            loveScore = 100
        } else if score > 2 {
            loveScore = 90 + Int(round((score - 2) * 10))
        } else if score > 1 {
            loveScore = 80 + Int(round((score - 1) * 10))
        } else if score > 0 {
            loveScore = Int(round(score * 100) - 20)
        } else {
            loveScore = 100
        }
        
    }
    
    var body: some View {
        let notiName = "com.techchee.test.notification"
        let pub = NotificationCenter.default.publisher(
            for: Notification.Name(notiName))
        let ideas = LL_Ideas()
        
        
            
            
            ZStack {
                Color(K.Color.BrandColor7)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Hi, Welcome Back")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(Color(K.Color.BrandColor2))
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                    
                        
                        

                        ZStack{
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color(K.Color.BrandColor1))
                                .shadow(radius: 5, x:3, y:3)
                        

                            VStack(alignment: .leading, spacing: 10){
                            Text(appHeader)
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(K.Color.BrandColor2))
                                .multilineTextAlignment(.leading)
                                .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                            Text(goalSubtitle)
                                    .multilineTextAlignment(.leading)
                                    .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                    .foregroundColor(Color(K.Color.BrandColor2))
                                .font(.system(size: 14, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                Divider()
                                Spacer()
                            
                                NotificationsView(appHeader: $appHeader, goalSubtitle: $goalSubtitle, title: "Words of Affirmation", suggestions: ideas.wordsOfAffirmation, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.woa)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.woa)), id: "woa" )
                                NotificationsView(appHeader: $appHeader, goalSubtitle: $goalSubtitle, title: "Quality Time", suggestions: ideas.qualityTime , date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.qt)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.qt)), id: "qt")
                                NotificationsView(appHeader: $appHeader, goalSubtitle: $goalSubtitle, title: "Physical Touch", suggestions: ideas.physicalTouch, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.pt)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.pt)), id: "pt" )
                                NotificationsView(appHeader: $appHeader, goalSubtitle: $goalSubtitle, title: "Receiving Gifts", suggestions: ideas.receivingGifts, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.rg)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.rg)), id: "rg" )
                                NotificationsView(appHeader: $appHeader, goalSubtitle: $goalSubtitle, title: "Acts of Service", suggestions: ideas.actsOfService, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.aos)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.aos)), id: "aos" )
                        }.padding(.top, 8)
                        .padding(.bottom, 30)
                        }.padding(.top, 20)
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                    ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color("Snow-1"))
                        .shadow(radius: 1, x:3, y:3)
                        VStack(alignment: .center, spacing: 0){
                        Text("Love Score")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(K.Color.BrandColor2))
                            .multilineTextAlignment(.leading)
                            
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                            .padding(.leading, 20)
                        
                        ZStack{
                            Image("heart")
                                .resizable()
                                .foregroundColor(.blue)
                                .aspectRatio(contentMode: .fit)
                                .frame(width:250, height:250, alignment: .center)
                            Text("\(loveScore)")
                                .font(.system(size: 42))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(K.Color.BrandColor1))
                                .multilineTextAlignment(.center)
                        }.onAppear{
                            calculateScore()
                        }
                            /*
                            Text("Great Work!")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(K.Color.BrandColor7))
                                .multilineTextAlignment(.leading)
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                */
                    }
                       
                    }.padding(.top, 8)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                    
                    
                    
                }.onAppear{
                    setupNotifications()
                    checkPendingNotifications()
                    
                    
                }.onReceive(pub){ data in
                    // execute other methods when the
                    // Combine publisher with the specified
                    // name received
                    print("Received notification")
                    if let content = (data.object as? UNNotificationContent){
                        print("title:\(content.title), subtitle:\(content.subtitle)")
                    }
                }.alert(isPresented : $toShowAlert){
                    
                    Alert(title: Text("Notification has been disabled for this app"),
                          message: Text("Please go to settings to enable it now"),
                          primaryButton: .default(Text("Go To Settings")) {
                            self.goToSettings()
                          },
                          secondaryButton: .cancel())
                }
                
            }
            
            
            
            
            
        
        
    }
    
    
    fileprivate func setupNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All Set!")
                
                
            } else if let error = error {
                print(error.localizedDescription)
                
                toShowAlert.toggle()
            } else {
                print("Not enabled")
                //appHeader = "Enable Notifications Below"
                toShowAlert.toggle()
                //shouldShow = true
            }
            
        }
    }
    
    fileprivate func checkPendingNotifications(){
        let frequencyArray = ["woaFrequency", "qtFrequency", "ptFrequency", "aosFrequency", "rgFrequency"]
        let identifierArray = ["woa", "qt", "pt", "aos", "rg"]
        var count = 0
        for freq in frequencyArray{
            let numFreq = UserDefaults.standard.integer(forKey: freq)
            if numFreq != 0 {
                count+=1
            }
        }
        print("Number of not off settings is: \(count)")
        
        let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { (notifications) in
                let pendingNotificationCount = notifications.count
                print("Pending Notifications count is", pendingNotificationCount)
                var arrayOfNotificationIdentifiers: [String] = []
                for notification in notifications {
                    arrayOfNotificationIdentifiers.append(notification.identifier)
                }
                if pendingNotificationCount != count {
                    for identifier in identifierArray{
                        if !arrayOfNotificationIdentifiers.contains(identifier){
                            print("Missing notification for \(identifier)")
                            let frequency = UserDefaults.standard.integer(forKey: "\(identifier)Frequency")
                            let title = GetTitleForIdentifier(identifier: identifier) as String
                            switch frequency {
                            case 0:
                                print("Notification is set to off, doing nothing")
                            case 1:
                                let notificationDate = notificationHandler.setDailyNotification(notification: rDailyNotification(triggerIdentifier: identifier, title: title, body: "", triggerHour: Int.random(in: 8...20), date: Date()))
                                print("Set \(title) Notification for: \(notificationDate)")
                                
                                UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(identifier)Date")
                                UserDefaults.standard.synchronize()
                                
                            case 2:
                                let notificationDate = notificationHandler.setWeeklyNotification(notification: rWeeklyNotification(triggerIdentifier: identifier, title: title, body: "", triggerHour: Int.random(in: 8...20), triggerDay: 0, date: Date()))
                                print("Set \(title) Notification for \(notificationDate)")
                                UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(identifier)Date")
                                UserDefaults.standard.synchronize()
                            case 3:
                                let notificationDate = notificationHandler.setMonthlyNotification(notification: rMonthlyNotification(triggerIdentifier: identifier, title: title , body: "", triggerHour: Int.random(in: 8...20), triggerMonth: 0, date: Date()))
                                print("Set Receiving Gift Reminder for \(notificationDate)")
                                UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(identifier)Date")
                                UserDefaults.standard.synchronize()
                            default:
                                print("error, frequency not in range 0-3")
                            }
                        }
                    }
                }
            })
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}

extension ContentView {
    private func goToSettings(){
        // must execute in main thread
        DispatchQueue.main.async {
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:],
                                      completionHandler: nil)
        }
    }
}

func GetTitleForIdentifier(identifier: String) -> (String){
    switch identifier {
    case "woa":
        return K.woa
    case "qt":
        return K.qt
    case "pt":
        return K.pt
    case "rg":
        return K.rg
    case "aos" :
        return K.aos
    default:
        print("invalid identifier")
        return ""
    }
}


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
    @State var wakeupTime = 8
    @StateObject var notificationReceiver = NotificationReceiver()
    @State var loveScore = 100
    var notificationHandler = NotificationHandler()
    
    init() {
        UIToolbar.appearance().barTintColor = UIColor.red
    }
    
    
    
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
        
        NavigationView{
            
            
            ZStack {
                Color(K.Color.BrandColor1)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView{
            
                        
                        

                        ZStack{
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color(K.Color.BrandColor7))
                                .shadow(radius: 5, x:3, y:3)
                        

                            VStack(alignment: .leading, spacing: 10){
                            Text(appHeader)
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(K.Color.BrandColor2))
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            NotificationsView(appHeader: $appHeader, title: "Words of Affirmation", suggestions: ideas.wordsOfAffirmation, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.woa)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.woa)), id: "woa" )
                            NotificationsView(appHeader: $appHeader, title: "Quality Time", suggestions: ideas.qualityTime , date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.qt)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.qt)), id: "qt")
                            NotificationsView(appHeader: $appHeader, title: "Physical Touch", suggestions: ideas.physicalTouch, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.pt)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.pt)), id: "pt" )
                            NotificationsView(appHeader: $appHeader, title: "Receiving Gifts", suggestions: ideas.receivingGifts, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.rg)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.rg)), id: "rg" )
                            NotificationsView(appHeader: $appHeader, title: "Acts of Service", suggestions: ideas.actsOfService, date: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.Notifications.Date.aos)), clearDate: Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: K.ClearDate.aos)), id: "aos" )
                        }.padding(.top, 8)
                        .padding(.bottom, 30)
                        }.padding(.top, 20)
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                    ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color(K.Color.BrandColor0))
                        .shadow(radius: 1, x:3, y:3)
                        VStack(alignment: .center, spacing: 0){
                        Text("Love Score")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(K.Color.BrandColor7))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        
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
                    }
                    }.padding(.top, 8)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                    
                    
                }.onAppear{
                    setupNotifications()
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
                
            }.blueNavigation
            .navigationBarTitle("Home")
            .toolbar(content: {
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                        .font(.system(size: 14, weight: .semibold))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(K.Color.BrandColor2))
                        .multilineTextAlignment(.center)
                    Image(systemName: "gear")
                        .font(.system(size: 18))
                        .foregroundColor(Color(K.Color.BrandColor2))
                        .multilineTextAlignment(.center)
                        
                    
                } 
            }
            
            )
            
            
        }.navigationBarTitle("Settings")
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


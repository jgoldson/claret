//
//  SettingsView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/9/21.
//

import Foundation
import SwiftUI
import UserNotifications

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            
            Color(K.Color.BrandColor7)
                .edgesIgnoringSafeArea(.all)
        ScrollView{
        
            VStack(alignment: .center){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Text("Settings")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(Color(K.Color.BrandColor2))
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                
                FrequencySelectorView()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        
        
        .toolbar(content: {
            Button(action: {
                viewRouter.currentPage = "onboardingView"
            }, label: {
                Text("Onboarding")
                    .lineLimit(nil)
                    .foregroundColor(Color(K.Color.BrandColor2))
                    .font(.system(size: 14, weight: .semibold))
                    
                    
                    .multilineTextAlignment(.center)
                
                Image(systemName: "return")
                    .font(.system(size: 20.0))
                    .foregroundColor(Color(K.Color.BrandColor2))
                    .multilineTextAlignment(.center)
                
                
                
            })
        })
        }
}
}
struct FrequencySelectorView: View {
    var body: some View {
        SettingSelectorView(title: K.woa, subtitle: K.Subtitles.woa, id: "woa")
            .padding(.top)
            
        SettingSelectorView(title: K.qt, subtitle: K.Subtitles.qt, id: "qt")
            
        SettingSelectorView(title: K.pt, subtitle: K.Subtitles.pt, id: "pt")
            
        SettingSelectorView(title: K.rg, subtitle: K.Subtitles.rg, id: "rg")
            
        SettingSelectorView(title: K.aos, subtitle: K.Subtitles.aos, id :  "aos")
            
            
    }
    
}


struct SettingSelectorView: View {
    let title: String
    let subtitle: String
    let id : String
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(K.Color.BrandColor0))
                .shadow(radius: 4, x:3, y:3)
            HStack() {
                
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(K.Color.BrandColor1))
                    .multilineTextAlignment(.center)
                    
                    .frame(maxWidth: 130, maxHeight: .infinity )
                    .padding(.leading, 8)
                
                
                
                frequencyButtonView(title: title, subtitle: subtitle, id: id)
                
            }
        }
        .padding(10)
    }
}

struct frequencyButtonView : View{
    
    @State var didTap1:Bool = false
    @State var didTap2:Bool = false
    @State var didTap3:Bool = false
    @State var didTap4:Bool = false
    let title: String
    let subtitle: String
    let id: String
    var notificationHandler = NotificationHandler()
    
    
    var body: some View {
        
        HStack{
            VStack{
                
                Button(action: {
                    print("Daily selected")
                    if didTap1 == false {
                        didTap1 = true
                        didTap2 = false
                        didTap3 = false
                        didTap4 = false
                        UserDefaults.standard.set(1, forKey: "\(id)Frequency")
                        UserDefaults.standard.synchronize()
                        let notificationDate = notificationHandler.setDailyNotification(notification: rDailyNotification(triggerIdentifier: id, title: title, body: subtitle, triggerHour: Int.random(in: 8...20), date: Date()))
                        print("Set \(title) Notification for: \(notificationDate)")
                        
                        UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(id)Date")
                        UserDefaults.standard.synchronize()
                    }
                } ){
                    FrequencyButton(title: "Daily", tapped: $didTap1)
                    
                }
                
                
                .multilineTextAlignment(.leading)
                .padding(.top, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                .foregroundColor(didTap1 ? Color(K.Color.BrandColor1) : Color(K.Color.BrandColor6))
                Button( action: {
                            print("Weekly selected")
                            if didTap2 == false {
                                didTap1 = false
                                didTap2 = true
                                didTap3 = false
                                didTap4 = false
                                UserDefaults.standard.set(2, forKey: "\(id)Frequency")
                                UserDefaults.standard.synchronize()
                                let notificationDate = notificationHandler.setWeeklyNotification(notification: rWeeklyNotification(triggerIdentifier: id, title: title, body: subtitle, triggerHour: Int.random(in: 8...20), triggerDay: 0, date: Date()))
                                print("Set \(title) Notification for \(notificationDate)")
                                UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(id)Date")
                                UserDefaults.standard.synchronize()
                                let date = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "\(id)Date"))
                                print(date)
                            }} ){
                    FrequencyButton(title: "Weekly", tapped: $didTap2)
                    
                }.multilineTextAlignment(.leading)
                .padding(.trailing, 10)
                
                .foregroundColor(didTap2 ? Color(K.Color.BrandColor1) : Color(K.Color.BrandColor6))
            }
            .padding(.bottom, 10)
            VStack{
                Button(action: {
                    print("Monthly selected")
                    if didTap3 == false {
                        didTap1 = false
                        didTap2 = false
                        didTap3 = true
                        didTap4 = false
                        UserDefaults.standard.set(3, forKey: "\(id)Frequency")
                        UserDefaults.standard.synchronize()
                        let notificationDate = notificationHandler.setMonthlyNotification(notification: rMonthlyNotification(triggerIdentifier: id, title: title , body: subtitle, triggerHour: Int.random(in: 8...20), triggerMonth: 0, date: Date()))
                        print("Set Receiving Gift Reminder for \(notificationDate)")
                        UserDefaults.standard.set(notificationDate.timeIntervalSince1970, forKey: "\(id)Date")
                        UserDefaults.standard.synchronize()
                    }
                }) {
                    FrequencyButton(title: "Monthly", tapped: $didTap3)
                }
                .multilineTextAlignment(.leading)
                .padding(.top, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                .foregroundColor(didTap3 ? Color(K.Color.BrandColor1) : Color(K.Color.BrandColor6))
                Button(action :{
                    print("Off selected")
                    if didTap4 == false {
                        didTap1 = false
                        didTap2 = false
                        didTap3 = false
                        didTap4 = true
                        UserDefaults.standard.set(0, forKey: "\(id)Frequency")
                        UserDefaults.standard.synchronize()
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
                        
                        
                    }
                })
                {FrequencyButton(title: "Off", tapped: $didTap4)}
                .multilineTextAlignment(.leading)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                .foregroundColor(didTap4 ? Color(K.Color.BrandColor1) : Color(K.Color.BrandColor6))
                .onAppear{
                    switch UserDefaults.standard.integer(forKey: "\(id)Frequency") {
                    case 0:
                        didTap1 = false
                        didTap2 = false
                        didTap3 = false
                        didTap4 = true
                    case 1:
                        didTap1 = true
                        didTap2 = false
                        didTap3 = false
                        didTap4 = false
                    case 2:
                        didTap1 = false
                        didTap2 = true
                        didTap3 = false
                        didTap4 = false
                    case 3:
                        didTap1 = false
                        didTap2 = false
                        didTap3 = true
                        didTap4 = false
                        
                    default:
                        didTap1 = false
                        didTap2 = false
                        didTap3 = false
                        didTap4 = false
                        print("Value not found")
                    }
                }
            }
            
        }.frame(maxWidth: .infinity)
        
        
    }
    
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}

struct FrequencyButton: View {
    let title: String
    @Binding var tapped: Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40, style: .circular)
                .fill(tapped ? Color(K.Color.BrandColor2) : Color(K.Color.BrandColor7))
                .frame(width: 90, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: 1)
            Text(title)
                .font(.system(size: 12, weight: .semibold))
        }
    }
}

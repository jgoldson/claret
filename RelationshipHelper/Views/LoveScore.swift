//
//  LoveScore.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 6/13/21.
//

import SwiftUI



struct LoveScore: View {
    @State var loveScore = 100
    
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
        ScrollView{
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text("Keep It Up!")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .foregroundColor(Color(K.Color.BrandColor2))
                .multilineTextAlignment(.leading)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding()
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
            }
            }
            .onAppear{
                calculateScore()
            }
            
        }.padding(.top, 8)
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .padding(.bottom, 8)
    }
}
}


struct LoveScore_Previews: PreviewProvider {
    static var previews: some View {
        LoveScore()
    }
}

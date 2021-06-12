//
//  FirstTimeFrequencyView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/25/21.
//

import SwiftUI

struct FirstTimeFrequencyView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack{
            Color(K.Color.BrandColor1)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
            VStack(alignment: .center){
            Text("Set Your Goal Frequency")
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .foregroundColor(Color(K.Color.BrandColor2))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding()

 
            FrequencySelectorView()
            Button(action : {
                withAnimation {
                    self.viewRouter.currentPage = "homeView"
                }
                
            })
            {
                HStack(alignment: .center){
                    Spacer()

            Image(systemName: "arrow.right")
                .resizable()
                .foregroundColor(Color(K.Color.BrandColor2))
                .frame(width: 30, height: 30, alignment: .center)
                .padding()
                .background(Color(K.Color.BrandColor0))
                .cornerRadius(30)
                }.padding(.trailing, 20)
                .padding(.top, 8)
                .padding(.bottom, 20)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }.frame(maxHeight: .infinity)
        }.frame(maxHeight: .infinity)
    }
}





struct FirstTimeFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeFrequencyView()
    }
}

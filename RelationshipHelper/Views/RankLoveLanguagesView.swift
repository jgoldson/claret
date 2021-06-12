//
//  RankLoveLanguagesView.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/25/21.
//

import SwiftUI

struct RankLoveLanguagesView: View {
    var body: some View {
        ZStack{
            Color(K.Color.BrandColor0)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Text("Set your partner's love languages")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(K.Color.BrandColor1))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Have your partner take a love language quiz to find out what they value and how they appreciate receiving love.")
                    .font(.system(size: 16))
                    
                    .foregroundColor(Color(K.Color.BrandColor1))
                    .multilineTextAlignment(.center)
                    .padding()
                DemoList()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct RankLoveLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        RankLoveLanguagesView()
    }
}

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct DemoList: View {
    @State private var items: [Item] = [Item(title: K.woa), Item(title: K.qt)]
    @State private var editMode = EditMode.inactive
    private static var count = 0

    init() {
       UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(named:K.Color.BrandColor0)!
        UITableView.appearance().backgroundColor = UIColor(named: K.Color.BrandColor0)!
    }
    var body: some View {
        
        NavigationView{
            
            List {
                
                ForEach(items) { item in
                    Text(item.title)
                }
                .onMove(perform: onMove)
            }.listRowBackground(Color.pink)
            
           .navigationBarTitle("List")
            .environment(\.editMode, $editMode)
 
        }
    }
    

    
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
        for provider in itemProvider {
            if provider.canLoadObject(ofClass: URL.self) {
                _ = provider.loadObject(ofClass: URL.self) { url, error in
                    DispatchQueue.main.async {
                        url.map { self.items.insert(Item(title: $0.absoluteString), at: offset) }
                    }
                }
            }
        }
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
}

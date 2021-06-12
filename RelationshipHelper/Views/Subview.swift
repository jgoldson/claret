//
//  Subview.swift
//  RelationshipHelper
//
//  Created by Jonathan Goldson on 5/24/21.
//

import SwiftUI

struct Subview: View {
    var imageString: String
    let system: Bool
    var body: some View {
        if !system {
        Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
        } else {
            Image(systemName: imageString)
                //.resizable()
                .font(.system(size: 250.0))
                .aspectRatio(contentMode: .fit)
                .clipped()
        }
    }
    
}

struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "checkmark.square", system: true)
    }
}

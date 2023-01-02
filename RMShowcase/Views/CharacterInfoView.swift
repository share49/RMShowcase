//
//  CharacterInfoView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import SwiftUI

struct CharacterInfoView: View {
    
    let header: String
    let firstField: String
    let secondField: String
    let cornerRadius = Constants.UI.containerCornerRadius
    let lineWidth = Constants.UI.containerLineWidth
    
    var body: some View {
        VStack {
            Text(header)
                .fontTitle2()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(firstField)
                        .fontBody()
                    
                    Text(secondField)
                        .fontBody()
                }
                .padding(.top)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.thickMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.black, lineWidth: lineWidth)
        )
    }
}

#if DEBUG
struct CharacterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInfoView(header: "Header", firstField: "Field", secondField: "Field")
    }
}
#endif

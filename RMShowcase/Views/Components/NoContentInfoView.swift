//
//  NoContentInfoView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import SwiftUI

struct NoContentInfoView: View {
    
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .padding(Constants.UI.bigMargin)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

#if DEBUG
struct NoContentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NoContentInfoView(text: ls.noCharacters)
    }
}
#endif

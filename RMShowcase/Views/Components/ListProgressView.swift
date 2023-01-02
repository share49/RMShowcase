//
//  ListProgressView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import SwiftUI

struct ListProgressView: View {
    
    var topMargin = Constants.UI.bigMargin
    
    var body: some View {
        VStack {
            ProgressView()
                .padding(.top, topMargin)
            
            Spacer()
        }
    }
}

#if DEBUG
struct ListProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ListProgressView()
    }
}
#endif

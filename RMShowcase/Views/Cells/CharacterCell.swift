//
//  CharacterCell.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import SwiftUI

struct CharacterCell: View {
    
    @StateObject var viewModel: CharacterCellViewModel
    private let avatarHeight = Constants.UI.avatarHeight
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.uiImage)
                .resizable()
                .frame(width: avatarHeight, height: avatarHeight)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(Constants.UI.avatarCornerRadius)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .fontTitle2()
                
                Text(viewModel.status)
                    .fontBody()
                
                Text(viewModel.speciesAndGender)
                    .fontBody()
                
                Spacer()
            }
            .padding(.leading, Constants.UI.smallMargin)
            .padding([.vertical, .trailing])
            
            Spacer()
        }
        .onAppear {
            Task { await viewModel.fetchImage() }
        }
        .onDisappear {
            Task { await viewModel.cancelFetchImage() }
        }
    }
}

#if DEBUG
struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(viewModel: CharacterCellViewModel.mock)
    }
}
#endif

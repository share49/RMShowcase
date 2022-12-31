//
//  CharactersListView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel: CharactersViewModel
    
    var body: some View {
        ContentLoadingView({
            List(viewModel.characters) { character in
                CharacterCell(character: character)
            }
        }, noContentInfo: viewModel.noContentText, isLoading: viewModel.isLoading, hasContent: viewModel.hasItems)
        .navigationTitle(viewModel.title)
        .alertView(for: $viewModel.alertMessage)
        .task {
            await viewModel.loadCharacters()
        }
    }
}

#if DEBUG
struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharactersListView(viewModel: CharactersViewModel.mock)
        }
    }
}
#endif

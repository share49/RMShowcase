//
//  CharactersListView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel: CharactersViewModel
    let imageFetcher: ImageFetcher
    
    var body: some View {
        ContentLoadingView({
            List(viewModel.characters) { character in
                CharacterCell(viewModel: CharacterCellViewModel(character: character, imageFetcher: imageFetcher))
                    .onAppear {
                        Task(priority: .userInitiated) {
                            await viewModel.loadMoreCharactersIfNeeded(currentCharacterId: character.id)
                        }
                    }
            }
        }, noContentInfo: viewModel.noContentText, isLoading: viewModel.isFirstLoad, hasContent: viewModel.hasItems)
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
            CharactersListView(viewModel: CharactersViewModel.mock, imageFetcher: ImageLoader())
        }
    }
}
#endif

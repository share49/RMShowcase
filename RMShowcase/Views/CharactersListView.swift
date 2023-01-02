//
//  CharactersListView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel: CharactersViewModel
    let networkService: NetworkProvider
    let imageFetcher: ImageFetcher
    
    var body: some View {
        ContentLoadingView({
            List(viewModel.items) { character in
                NavigationLink {
                    CharacterDetailView(viewModel: CharacterDetailViewModel(
                        character: character,
                        networkService: networkService,
                        imageFetcher: imageFetcher)
                    )
                } label: {
                    CharacterCell(viewModel: CharacterCellViewModel(character: character, imageFetcher: imageFetcher))
                        .onAppear {
                            Task(priority: .userInitiated) {
                                await viewModel.loadMoreCharactersIfNeeded(currentItemId: character.id)
                            }
                        }
                }
            }
        }, noContentInfo: viewModel.noContentText, isLoading: viewModel.showLoadingView, hasContent: viewModel.hasItems)
        .searchable(text: $viewModel.searchedText, prompt: viewModel.searchHint)
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
            CharactersListView(viewModel: CharactersViewModel.mock, networkService: NetworkService(), imageFetcher: ImageLoader())
        }
    }
}
#endif

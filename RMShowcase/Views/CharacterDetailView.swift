//
//  CharacterDetailView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            CharacterInfoView(
                header: viewModel.name,
                firstField: viewModel.speciesAndSpecies,
                secondField: viewModel.location
            )
            .padding(.horizontal)
            
            Spacer()
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#if DEBUG
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(viewModel: CharacterDetailViewModel(
            character: Character.mock,
            networkService: MockNetworkService(result: .success(item: DetailedCharacterResponse.mock)),
            imageFetcher: ImageLoader())
        )
    }
}
#endif

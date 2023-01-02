//
//  CharacterDetailViewModel.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import UIKit

@MainActor final class CharacterDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private var character: Character
    private let networkService: NetworkProvider
    private let imageFetcher: ImageFetcher
    @Published private(set) var uiImage: UIImage
    
    // MARK: - Initializer
    
    init(
        character: Character,
        networkService: NetworkProvider,
        imageFetcher: ImageFetcher,
        uiImage: UIImage = UIImage(named: Constants.Image.avatarPlaceholder)!
    ) {
        self.character = character
        self.networkService = networkService
        self.imageFetcher = imageFetcher
        self.uiImage = uiImage
    }
    
    // MARK: - View data
    
    var name: String {
        character.name
    }
    
    var speciesAndSpecies: String {
        "\(character.status) - \(character.species)"
    }
    
    var location: String {
        character.locationName ?? ls.unknown
    }
    
    // MARK: - Methods
    
    func loadData() async {
        do {
            await fetchImage()
            let detailedCharacterResponse = try await networkService.character(by: character.id)
            character = Character(withResponse: detailedCharacterResponse)
        } catch {
            RMLogger.shared.error("CharacterDetailVM: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Support methods
    
    private func fetchImage() async {
        do {
            uiImage = try await imageFetcher.fetch(character.imageUrlString)
        } catch {
            RMLogger.shared.error("CharacterDetailVM: Fetch image: \(error.localizedDescription)")
        }
    }
}

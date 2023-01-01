//
//  CharacterCellViewModel.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import UIKit

@MainActor final class CharacterCellViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let character: Character
    private let imageFetcher: ImageFetcher
    @Published private(set) var uiImage = UIImage(named: Constants.Image.avatarPlaceholder)!
    
    // MARK: - Initializer
    
    init(character: Character, imageFetcher: ImageFetcher) {
        self.character = character
        self.imageFetcher = imageFetcher
    }
    
    // MARK: - View data
    
    var name: String {
        character.name
    }
    
    var status: String {
        "\(ls.characterStatus): \(character.status)"
    }
    
    var speciesAndGender: String {
        "\(character.species) - \(character.gender)"
    }
    
    // MARK: - Methods
    
    func fetchImage() async {
        guard let url = URL(string: character.imageUrlString) else {
            RMLogger.shared.error("CharacterCellVM: Can't get URL for: \(character.imageUrlString)")
            return
        }
        
        do {
            uiImage = try await imageFetcher.fetch(url)
        } catch {
            RMLogger.shared.error("CharacterCellVM: Can't fetch image. \(error.localizedDescription)")
        }
    }
    
    func cancelFetchImage() async {
        guard let url = URL(string: character.imageUrlString) else {
            RMLogger.shared.error("CharacterCellVM: Can't get URL for: \(character.imageUrlString)")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        await imageFetcher.cancelRequest(urlRequest)
    }
}

#if DEBUG
extension CharacterCellViewModel {
    static let mock = CharacterCellViewModel(character: Character.mock, imageFetcher: ImageLoader())
}
#endif

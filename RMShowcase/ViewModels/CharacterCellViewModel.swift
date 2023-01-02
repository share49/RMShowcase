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
    @Published private(set) var uiImage: UIImage
    
    // MARK: - Initializer
    
    init(
        character: Character,
        imageFetcher: ImageFetcher,
        uiImage: UIImage = UIImage(named: Constants.Image.avatarPlaceholder)!
    ) {
        self.character = character
        self.imageFetcher = imageFetcher
        self.uiImage = uiImage
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
        do {
            uiImage = try await imageFetcher.fetch(character.imageUrlString)
        } catch let error as NSError where error.code == Constants.API.ErrorCodes.cancelled {
            RMLogger.shared.debug("CharacterCellVM: \(error.localizedDescription)")
        } catch {
            RMLogger.shared.error("CharacterCellVM: Can't fetch image. \(error.localizedDescription)")
        }
    }
    
    func cancelFetchImage() async {
        await imageFetcher.cancelFetch(character.imageUrlString)
    }
}

#if DEBUG
extension CharacterCellViewModel {
    static let mock = CharacterCellViewModel(character: Character.mock, imageFetcher: ImageLoader())
}
#endif

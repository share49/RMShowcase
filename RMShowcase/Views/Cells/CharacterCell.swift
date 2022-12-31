//
//  CharacterCell.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import SwiftUI

struct CharacterCell: View {
    
    let character: Character
    
    var body: some View {
        Text(character.name)
    }
}

#if DEBUG
struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: Character.mock)
    }
}
#endif

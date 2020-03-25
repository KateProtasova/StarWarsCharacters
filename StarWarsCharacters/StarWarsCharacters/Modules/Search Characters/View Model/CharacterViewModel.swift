//
//  CharacterViewModel.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 22.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class CharacterViewModel {

    let name: String

    init(character: Character) {
        self.name = character.name
    }
}

//
//  Characters.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 22.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

protocol Nextable {
    var next: String? { get }
}

typealias PagingModel = Nextable & Codable

class Characters: PagingModel {
    let count: Int
    let next: String?
    let previous: String?
    var results: [Character] = []

    init(count: Int, next: String?, previous: String?, results: [Character]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

class Character: Codable, CustomStringConvertible {

    let name: String
//    let height: String
//    let mass: String
//    let hairColor: String
//    let skinColor: String
//    let eyeColor: String
//    let birthYear: String
//    let gender: String
//    let homeworld: String
//    let films, species, vehicles, starships: [String]
//    let created, edited: String
//    let url: String

    init(name: String ) {//, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, birthYear: String, gender: String, homeworld: String, films: [String], species: [String], vehicles: [String], starships: [String], created: String, edited: String, url: String) {
        self.name = name
//        self.height = height
//        self.mass = mass
//        self.hairColor = hairColor
//        self.skinColor = skinColor
//        self.eyeColor = eyeColor
//        self.birthYear = birthYear
//        self.gender = gender
//        self.homeworld = homeworld
//        self.films = films
//        self.species = species
//        self.vehicles = vehicles
//        self.starships = starships
//        self.created = created
//        self.edited = edited
//        self.url = url
    }

    var description: String {
        return name
    }
}

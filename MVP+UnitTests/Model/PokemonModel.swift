//
//  Person.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation
import UIKit

struct PokemonModel: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let url: String
}

struct CurrentPokemon: Decodable {
    let sprites: Images
}

struct Images: Decodable {
    let other: Artwork
}

struct Artwork: Decodable {
    let artwork: PokemonImage

    private enum CodingKeys: String, CodingKey {
        case artwork = "official-artwork"
    }
}

struct PokemonImage: Decodable {
    let pokemonImage: String
    
    private enum CodingKeys: String, CodingKey {
        case pokemonImage = "front_default"
    }
}

struct PokemonData: Decodable {
    let name: String
    let url: String
    let image: String
}

struct CurrentPokemonModel {
    let name: String
    let url: String
    let image: UIImage
}

//
//  PokeAppModel.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import Foundation

struct Pokemon: Hashable {

    let id = UUID()
    let name: String
    let url: String
    var isFavourite = false
}

struct PokemonList: Codable {

    let count: Int
    let results: [PokemonRow]
}

struct PokemonRow: Codable, Hashable {
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    
    let id: Int
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [Types]
    
    struct Sprites: Codable {
        let front_default: String
    }
    
    struct Types: Codable {
        let slot: Int
        let type: Species
        
        struct Species: Codable {
            let name: String
            let url: String
        }
    }
}



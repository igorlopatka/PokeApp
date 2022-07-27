//
//  PokeAppModel.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import Foundation

struct PokemonPage: Codable {
    
    let count: Int
    let results: [Pokemon]
}

struct Pokemon: Codable, Hashable {

    let name: String
    let url: String
}

struct PokemonRow: Hashable {

    let id = UUID()
    let name: String
    let url: String
    var isFavourite = false
}

struct DetailPokemon: Codable {
    
    let id: Int
    let height: Int
    let weight: Int
}

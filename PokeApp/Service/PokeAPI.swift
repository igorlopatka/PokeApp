//
//  PokeAPI.swift
//  PokeApp
//
//  Created by Igor Łopatka on 13/03/2023.
//

import Foundation

struct PokeAPI {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    static let pokemonList = baseURL.appendingPathComponent("pokemon")
}

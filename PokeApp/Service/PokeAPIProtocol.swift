//
//  PokeAPIProtocol.swift
//  PokeApp
//
//  Created by Igor Łopatka on 13/03/2023.
//

import Foundation
import Combine

protocol PokeAPIProtocol {
    
    func getPokemonList() -> AnyPublisher<[Pokemon], Error>
    func getPokemonDetails(url: URL) -> AnyPublisher<PokemonDetails, Error>
}

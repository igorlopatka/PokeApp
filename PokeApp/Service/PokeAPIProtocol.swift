//
//  PokeAPIProtocol.swift
//  PokeApp
//
//  Created by Igor Łopatka on 13/03/2023.
//

import Foundation
import Combine

protocol PokeAPIProtocol {
    
    func getPokemonList(offset: Int, limit: Int) -> AnyPublisher<[PokemonRow], Error>
    func getPokemonDetails(url: URL) -> AnyPublisher<PokemonDetails, Error>
}

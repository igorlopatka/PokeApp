//
//  PokeAPIService.swift
//  PokeApp
//
//  Created by Igor Łopatka on 11/03/2023.
//

import Foundation
import Combine

class PokemonService: PokeAPIProtocol {
  
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func getPokemonList() -> AnyPublisher<[Pokemon], Error> {
        
        let request = URLRequest(url: PokeAPI.pokemonList)
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PokemonList.self, decoder: JSONDecoder())
            .map { response in
                response.results.map { Pokemon(name: $0.name, url: $0.url, isFavourite: false) }
            }
            .eraseToAnyPublisher()
    }
    
    func getPokemonDetails(url: URL) -> AnyPublisher<PokemonDetails, Error> {
        
        let request = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PokemonDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

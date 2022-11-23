//
//  PokeAppViewModel.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import Foundation
import SwiftUI

@MainActor class PokeAppViewModel: ObservableObject {
        
    @Published var pokemonsList = [Pokemon]()
    @Published var loadingState = LoadingState.loading
    @Published var searchText = ""
    @Published var showFavs = false
    
    var listIsFull = false
    var offset = 0
    let limit = 20
    
    var pokemons = [PokemonRow]()
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var searchResults: [Pokemon] {
        get {
            if searchText.isEmpty {
                if showFavs {
                    return pokemonsList.filter { pokemon in
                        pokemon.isFavourite
                    }
                } else {
                    return pokemonsList 
                }
            } else {
                
                return pokemonsList.filter { $0.name.lowercased().contains(searchText.lowercased())}
            }
        }
        set {
            objectWillChange.send()
        }
    }
    
    var favouritePokemons: [Pokemon] {
            searchResults.filter { pokemon in
                (!showFavs || pokemon.isFavourite)
            }
        }

    
    func managePokemonList() {
        if pokemonsList.isEmpty {
            Task {
                await fetchPokemons()
            }
        }
    }
    
    func fetchPokemons() async {
        let urlString = "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(PokemonList.self, from: data)
            
            pokemons = items.results
            
            for pokemon in pokemons {
                
                let pokemonRow = Pokemon(name: pokemon.name,
                                         url: pokemon.url,
                                         isFavourite: false)
                
                pokemonsList.append(pokemonRow)
                
            }
            
            loadingState = .loaded
            
        } catch {
            loadingState = .failed
            print("Error fetching pokemons: \(error)")
            return
        }
    }
    
    func getPokemonDetails(pokemon: PokemonRow) async -> PokemonDetails? {
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let result = try JSONDecoder().decode(PokemonDetails.self, from: data)
            print("2")
            let pokemonDetails = result
            
            print(pokemonDetails)
            
            return pokemonDetails
                
    
        } catch {
            print("Error fetching pokemon details: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonsList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func addFav(_ pokemon: Pokemon) {
        if let chosenPokemonIndex = self.pokemonsList.firstIndex(of: pokemon) {
            pokemonsList[chosenPokemonIndex].isFavourite.toggle()
        }
    }
    
    func imageURL(pokemon: Pokemon) -> String {
        let imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(getPokemonIndex(pokemon: pokemon)).png"
        return imageURL
    }
}

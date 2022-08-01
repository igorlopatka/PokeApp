//
//  PokeAppViewModel.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import Foundation

@MainActor class PokeAppViewModel: ObservableObject {
    
    @Published var pokemonsList = [PokemonRow]()
    @Published var loadingState = LoadingState.loading
    @Published var searchText = ""
    @Published var showFavs = false
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var searchResults: [PokemonRow] {
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
    
    var favouritePokemons: [PokemonRow] {
            searchResults.filter { pokemon in
                (!showFavs || pokemon.isFavourite)
            }
        }

    
    func managePokemonList() {
        if pokemonsList.isEmpty {
            Task {
                await getPokemonList()
            }
        }
    }
    
    func getPokemonList() async {
        let urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1153"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(PokemonPage.self, from: data)
            
            var pokemons = [Pokemon]()
            pokemons = items.results
            
            for pokemon in pokemons {
                
                let pokemonRow = PokemonRow(name: pokemon.name, url: pokemon.url, isFavourite: false)
                pokemonsList.append(pokemonRow)
                
            }
            
            loadingState = .loaded
            
        } catch {
            loadingState = .failed
            print("Error fetching pokemons: \(error)")
            return
        }
    }
    
    func getPokemonIndex(pokemon: PokemonRow) -> Int {
        if let index = self.pokemonsList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func addFav(_ pokemon: PokemonRow) {
        if let chosenPokemonIndex = self.pokemonsList.firstIndex(of: pokemon) {
            pokemonsList[chosenPokemonIndex].isFavourite.toggle()
        }
    }
}

//
//  ContentView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject private var viewModel = PokeAppViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.loadingState {
                case .loaded:
                    List {
                        ForEach(viewModel.searchResults, id: \.self) { pokemon in
                            NavigationLink(destination: {
                                PokemonDetailsView(viewModel: viewModel, pokemon: pokemon)
                            }, label: {
                                PokemonRowView(viewModel: viewModel, pokemon: pokemon)
                            })
                            .swipeActions {
                                Button { viewModel.addFav(pokemon) } label: { Label("Favourite", systemImage: "star.fill") }
                            }
                            .tint(.yellow)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .searchable(text: $viewModel.searchText)
                    
                case .loading:
                    ProgressView()
                case .failed:
                    Text("Failed to load Pokemons :(")
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("My Pokemons")
            .toolbar(content: {
                ToolbarItem {
                    Button {
                        withAnimation {
                            viewModel.showFavs.toggle()
                        }
                    } label: {
                        if viewModel.showFavs {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                        }
                    }

                }
            })
            .task {
                viewModel.managePokemonList()
            }
        }
    }
}

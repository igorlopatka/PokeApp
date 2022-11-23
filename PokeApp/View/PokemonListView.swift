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
                        if viewModel.listIsFull == false && viewModel.showFavs == false {
                            ProgressView()
                                .onAppear {
                                    Task {
                                        await viewModel.fetchPokemons()
                                    }
                                }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .searchable(text: $viewModel.searchText, prompt: "Which Pokémon are you looking for?")
                    
                case .loading:
                    ProgressView()
                case .failed:
                    Text("Failed to load Pokémons :(")
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("My Pokémons")
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

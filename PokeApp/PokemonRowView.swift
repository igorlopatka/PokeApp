//
//  PokemonRowView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 21/07/2022.
//

import SwiftUI

struct PokemonRowView: View {
    
    let viewModel: PokeAppViewModel
    let pokemon: PokemonRow
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(viewModel.getPokemonIndex(pokemon: pokemon)).png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 35))
            
            VStack {
                HStack {
                    Text(pokemon.name.capitalized)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text("Pokémon of type fire")
                    Spacer()
                }
            }
                        
            if pokemon.isFavourite {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.yellow)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
            }
        }
    }
}




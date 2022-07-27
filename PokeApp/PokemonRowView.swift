//
//  PokemonRowView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 21/07/2022.
//

import SwiftUI

struct PokemonRowView: View {
    
    let viewModel: PokeAppViewModel
    
    @State var pokemon: PokemonRow
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(viewModel.getPokemonIndex(pokemon: pokemon)).png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 35))
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .lineLimit(1)
            
            Spacer()
            
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




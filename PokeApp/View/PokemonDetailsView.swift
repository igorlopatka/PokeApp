//
//  PokemonDetailsView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @ObservedObject var viewModel: PokeAppViewModel
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.imageURL(pokemon: pokemon))) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)
            .scaledToFill()
            .clipShape(Circle())
            HStack {
                Image(systemName: pokemon.isFavourite ? "star.fill" :"star")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.yellow)
                Text(pokemon.name.capitalized)
                    .fontWeight(.bold)
                    .font(.largeTitle)
            }
        }
    }
}


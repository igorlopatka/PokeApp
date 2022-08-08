//
//  PokemonDetailsView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @ObservedObject var viewModel: PokeAppViewModel
    
    let pokemon: PokemonRow
    
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
                Image(pokemon.isFavourite ? "star-solid" :"star-regular")
                    .resizable()
                    .frame(width: 40, height: 37.5, alignment: .center)
                    .foregroundColor(.yellow)
                Text(pokemon.name.capitalized).fontWeight(.bold)
            }
        }
    }
}


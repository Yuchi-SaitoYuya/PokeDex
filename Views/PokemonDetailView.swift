//
//  PokemonDetailView.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/15
//  
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)

            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()
        }
        .padding()
        .navigationTitle(pokemon.name.capitalized)
    }
}

//
//  ContentView.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/10
//  
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokeAPI = PokeAPI()

    var body: some View {
        NavigationView {
            List(pokeAPI.pokemonList.sorted(by: { $0.id < $1.id })) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    HStack {
                        AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)

                        Text(pokemon.name.capitalized)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("ポケモン図鑑")
            .onAppear {
                pokeAPI.fetchPokemon()
            }
        }
    }
}

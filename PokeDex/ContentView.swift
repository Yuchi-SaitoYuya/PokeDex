//
//  ContentView.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/10
//  
//

import SwiftUI

// メインのビューとなる ContentView
struct ContentView: View {
    // PokeAPI のインスタンスを作成し、ポケモンデータを取得・管理
    @StateObject var pokeAPI = PokeAPI()

    // View の中身を定義
    var body: some View {
        // ナビゲーション機能を提供するビュー
        NavigationView {
            // ポケモン一覧を ID 順にソートして表示
            List(pokeAPI.pokemonList.sorted(by: { $0.id < $1.id })) { pokemon in
                // 各ポケモンをタップすると詳細画面に遷移
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    HStack {
                        // ポケモンの画像を非同期で取得して表示
                        AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                            image.resizable().scaledToFit() // 画像のサイズを適切に調整
                        } placeholder: {
                            ProgressView() // 画像読み込み中のインジケーター
                        }
                        .frame(width: 50, height: 50) // 画像のサイズを指定

                        // ポケモンの名前を表示（先頭の文字を大文字にする）
                        Text(pokemon.name.capitalized)
                            .font(.headline) // 見出しフォントを適用
                    }
                }
            }
            .navigationTitle("ポケモン図鑑") // 画面のタイトルを設定
            .onAppear {
                // 画面表示時にポケモンデータを取得
                pokeAPI.fetchPokemon()
            }
        }
    }
}

//
//  PokeAPI.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/11
//  
//

import Foundation

// ポケモンのデータを取得・管理するクラス
// ObservableObject を採用して SwiftUI のビューと連携
class PokeAPI: ObservableObject {
    @Published var pokemonList: [Pokemon] = []  // 取得したポケモン一覧を格納

    // APIからポケモン情報を取得する関数
    func fetchPokemon() {
        let baseURL = "https://pokeapi.co/api/v2/pokemon/"
        let pokemonIDs = 1...20  // 1〜20のポケモンを取得

        for id in pokemonIDs {
            guard let url = URL(string: "\(baseURL)\(id)") else { continue }

            // 非同期でAPIリクエストを実行
            URLSession.shared.dataTask(with: url) { data, response, error in
                // エラーチェックとデータの取得
                guard let data = data, error == nil else { return }

                do {
                    // JSONをデコードしてPokemon型に変換
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

                    // メインスレッドでUIを更新
                    DispatchQueue.main.async {
                        self.pokemonList.append(pokemon)
                    }
                } catch {
                    print("Decoding Error: \(error)")
                }
            }.resume()
        }
    }
}


//
//  PokeAPI.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/11
//  
//

import Foundation

// ポケモンのデータを取得・管理するクラス
// SwiftUIのビューとデータを連携させるために ObservableObject を採用
class PokeAPI: ObservableObject {

    // 取得したポケモン一覧を格納する配列
    // @Published をつけることでデータが変更された際にビューが自動更新される
    @Published var pokemonList: [Pokemon] = []

    // APIからポケモン情報を取得する関数
    func fetchPokemon() {
        let baseURL = "https://pokeapi.co/api/v2/pokemon/" // ポケAPIのエンドポイント
        let pokemonIDs = 1...20  // 1〜20のポケモンを取得

        // 指定した範囲のポケモンIDごとにAPIリクエストを実行
        for id in pokemonIDs {
            guard let url = URL(string: "\(baseURL)\(id)") else { continue } // URLを生成し、失敗したらスキップ

            // 非同期でAPIリクエストを実行
            URLSession.shared.dataTask(with: url) { data, response, error in

                // データ取得のエラーチェック（エラーがあれば処理を中断）
                guard let data = data, error == nil else { return }

                do {
                    // 取得したJSONデータを Pokemon 構造体にデコード
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

                    // SwiftUI のUI更新はメインスレッドで行う必要があるため、DispatchQueue を使用
                    DispatchQueue.main.async {
                        self.pokemonList.append(pokemon) // デコードしたポケモンデータを配列に追加
                    }
                } catch {
                    print("Decoding Error: \(error)") // デコードに失敗した場合のエラーハンドリング
                }
            }.resume() // 通信処理を開始
        }
    }
}

//
//  PokemonDetailView.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/15
//  
//

import SwiftUI

// ポケモンの詳細画面を表示するビュー
struct PokemonDetailView: View {
    // 表示するポケモンのデータ（`Pokemon` 型のインスタンス）
    let pokemon: Pokemon

    var body: some View {
        VStack {
            // ポケモンの画像を非同期で取得・表示
            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                image.resizable().scaledToFit() // 画像をリサイズし、比率を維持してフィット
            } placeholder: {
                ProgressView() // 画像が読み込まれるまでインジケーターを表示
            }
            .frame(width: 200, height: 200) // 画像サイズを 200x200 に固定

            // ポケモンの名前を表示（先頭を大文字に）
            Text(pokemon.name.capitalized)
                .font(.largeTitle) // 大きなタイトルフォントを適用
                .fontWeight(.bold) // 太字にする

            Spacer() // 余白を追加して、上部に要素を寄せる
        }
        .padding() // 画面端に適度な余白を追加
        .navigationTitle(pokemon.name.capitalized) // 画面のタイトルをポケモン名に設定
    }
}

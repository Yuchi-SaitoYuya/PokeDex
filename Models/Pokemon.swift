//
//  Pokemon.swift
//  PokeDex
//  
//  Created by Yuchinante on 2025/03/10
//  
//

import Foundation

// ポケモンの基本情報を保持するモデル
// Codable: JSONデータとSwiftのオブジェクトを相互変換するためのプロトコル
// Identifiable: SwiftUIのListなどで一意に識別できるようにするためのプロトコル
struct Pokemon: Codable, Identifiable {
    let id: Int           // ポケモンの識別ID（図鑑番号）
    let name: String      // ポケモンの名前（英語表記）
    let sprites: Sprites  // ポケモンの画像データ
}

// ポケモンの画像データを管理する構造体
struct Sprites: Codable {
    let front_default: String  // ポケモンの正面画像URL
}

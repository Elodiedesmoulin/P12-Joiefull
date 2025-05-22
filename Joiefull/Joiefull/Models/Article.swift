//
//  Article.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

struct Article: Identifiable, Codable {
    let id: Int
    let picture: Picture
    let name: String
    let category: String
    let likes: Int
    let price: Double
    let original_price: Double
}

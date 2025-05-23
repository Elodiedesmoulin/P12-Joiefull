//
//  RatedArticle.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

struct RatedArticle: Identifiable {
    let article: Article
    let rating: Double
    var isFavorite: Bool = false

    var id: Int { article.id }
}

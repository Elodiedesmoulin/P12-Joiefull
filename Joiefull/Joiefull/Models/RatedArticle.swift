//
//  RatedArticle.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

class RatedArticle: ObservableObject, Identifiable {
    let article: Article
    @Published var rating: Double
    @Published var isFavorite: Bool
    var id: Int { article.id }

    init(article: Article, rating: Double, isFavorite: Bool) {
        self.article = article
        self.rating = rating
        self.isFavorite = isFavorite
    }
}

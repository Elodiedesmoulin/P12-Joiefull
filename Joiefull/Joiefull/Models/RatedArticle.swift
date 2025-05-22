//
//  RatedArticle.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


struct RatedArticle: Identifiable {
    let article: Article
    let rating: Double

    var id: Int { article.id }
}
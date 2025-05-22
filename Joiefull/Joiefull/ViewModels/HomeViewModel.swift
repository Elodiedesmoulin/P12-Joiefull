//
//  HomeViewModel.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

class HomeViewModel: ObservableObject {
    @Published var ratedArticles: [RatedArticle] = []

    var groupedArticles: [String: [RatedArticle]] {
        Dictionary(grouping: ratedArticles, by: { $0.article.category })
    }

    init() {
        loadArticles()
    }

    private func loadArticles() {
        let rawArticles = APIService.loadArticles()
        self.ratedArticles = rawArticles.map {
            RatedArticle(article: $0, rating: Double.random(in: 1.0...5.0))
        }
    }

    func localizedCategory(_ category: String) -> String {
        switch category.uppercased() {
        case "TOPS": return "Hauts"
        case "BOTTOMS": return "Bas"
        case "ACCESSORIES": return "Sacs"
        case "SHOES": return "Chaussures"
        default: return category.capitalized
        }
    }
}

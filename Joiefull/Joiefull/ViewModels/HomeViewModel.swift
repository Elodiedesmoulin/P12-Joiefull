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

    func loadArticles() {
        let rawArticles = APIService.loadArticles()
        UserDataStore.shared.load()
        self.ratedArticles = rawArticles.map {
            let state = UserDataStore.shared.state(for: $0.id)
            return RatedArticle(article: $0, rating: Double(state.rating), isFavorite: state.isFavorite)
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

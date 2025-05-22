//
//  HomeViewModel.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

class HomeViewModel: ObservableObject {
    @Published var articles: [Article] = []

    var groupedArticles: [String: [Article]] {
        Dictionary(grouping: articles, by: { $0.category })
    }

    init() {
        loadArticles()
    }

    private func loadArticles() {
        self.articles = APIService.loadArticles()
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
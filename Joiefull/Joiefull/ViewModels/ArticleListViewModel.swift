//
//  ArticleListViewModel.swift
//  Joiefull
//
//  Created by Elo on 05/06/2025.
//


import Foundation
import Combine

final class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var userStates: [Int: UserArticleState] = [:]
    private let userStatesStore = UserStatesStore()

    init() {
        self.userStates = userStatesStore.load()
    }

    // MARK: - Loading
    
    func loadArticles() async {
        do {
            let articles: [Article] = try APIService.shared.fetchLocal(endpoint: "clothes")
            DispatchQueue.main.async {
                self.articles = articles
            }
        } catch {
            print("Error loading articles :", error)
        }
    }

    // MARK: - Persistance
    
    func isFavorite(_ article: Article) -> Bool {
        userStates[article.id]?.isFavorite ?? false
    }
    func toggleFavorite(for article: Article) {
        var state = userStates[article.id] ?? UserArticleState()
        state.isFavorite.toggle()
        userStates[article.id] = state
        userStatesStore.save(states: userStates)
        if let idx = articles.firstIndex(where: { $0.id == article.id }) {
            if state.isFavorite {
                articles[idx].likes += 1
            } else {
                articles[idx].likes = max(0, articles[idx].likes - 1)
            }
        }
    }
    func userRating(for article: Article) -> Int {
        userStates[article.id]?.userRating ?? 0
    }
    func setRating(for article: Article, rating: Int) {
        var state = userStates[article.id] ?? UserArticleState()
        state.userRating = rating
        userStates[article.id] = state
        userStatesStore.save(states: userStates)
    }
    func userComment(for article: Article) -> String {
        userStates[article.id]?.userComment ?? ""
    }
    func setComment(for article: Article, comment: String) {
        var state = userStates[article.id] ?? UserArticleState()
        state.userComment = comment
        userStates[article.id] = state
        userStatesStore.save(states: userStates)
    }

    func categoriesSorted() -> [String] {
        let cats = articles.map { $0.category }
        return Array(Set(cats)).sorted { label(for: $0) < label(for: $1) }
    }
    func label(for category: String) -> String {
        switch category.uppercased() {
        case "TOPS": return "Hauts"
        case "BOTTOMS": return "Bas"
        case "ACCESSORIES": return "Sacs"
        case "SHOES": return "Chaussures"
        default: return category.capitalized
        }
    }
}

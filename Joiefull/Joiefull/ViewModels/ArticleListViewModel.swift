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
    @Published var favorites: Set<Int> = []
    @Published var ratings: [Int: Int] = [:]
    @Published var comments: [Int: String] = [:]

    // MARK: - Chargement
    func loadArticles() async {
        do {
            let articles: [Article] = try APIService.shared.fetchLocal(endpoint: "clothes")
            DispatchQueue.main.async {
                self.articles = articles
            }
        } catch {
            print("Erreur lors du chargement des articles :", error)
        }
    }
    
    // MARK: - Métier
    func isFavorite(_ article: Article) -> Bool { favorites.contains(article.id) }
    func toggleFavorite(for article: Article) {
        if favorites.contains(article.id) {
            favorites.remove(article.id)
        } else {
            favorites.insert(article.id)
        }
    }
    func userRating(for article: Article) -> Int? { ratings[article.id] }
    func setRating(for article: Article, rating: Int) { ratings[article.id] = rating }
    func userComment(for article: Article) -> String? { comments[article.id] }
    func setComment(for article: Article, comment: String) { comments[article.id] = comment }
    
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

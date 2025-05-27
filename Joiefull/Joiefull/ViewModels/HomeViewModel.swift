//
//  HomeViewModel.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var ratedArticles: [RatedArticle] = []
    private let repository: ArticleRepositoryProtocol

    init(repository: ArticleRepositoryProtocol = ArticleRepository()) {
        self.repository = repository
    }

    func loadArticles() {
        Task {
            let result = await repository.fetchArticles()
            switch result {
            case .success(let articles):
                self.ratedArticles = articles
            case .failure:
                break
            }
        }
    }
}

extension HomeViewModel {
    var groupedArticles: [String: [RatedArticle]] {
        Dictionary(grouping: ratedArticles, by: { $0.article.category })
    }

    func localizedCategory(_ key: String) -> String {
        switch key {
        case "ACCESSORIES": return "Accessoires"
        case "BOTTOMS": return "Bas"
        case "SHOES": return "Chaussures"
        case "TOPS": return "Hauts"
        default: return key
        }
    }
}

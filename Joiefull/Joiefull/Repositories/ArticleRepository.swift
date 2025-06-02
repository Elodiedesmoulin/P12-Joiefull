//
//  ArticleRepository.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation


class ArticleRepository: ArticleRepositoryProtocol {
    private let apiService: ArticleServiceProtocol
    private let localStorage: UserDataStore

    init(apiService: ArticleServiceProtocol = ArticleService.fromLocalJSON(named: "clothes"),
         localStorage: UserDataStore = .shared) {
        self.apiService = apiService
        self.localStorage = localStorage
    }

    func fetchArticles() async -> Result<[RatedArticle], ArticleServiceError> {
        let result = await apiService.fetchArticles()

        switch result {
        case .success(let articles):
            localStorage.load()
            let rated = articles.map { article in
                let state = localStorage.state(for: article.id)
                return RatedArticle(article: article, rating: Double(state.rating), isFavorite: state.isFavorite)
            }
            return .success(rated)

        case .failure(let error):
            return .failure(error)
        }
    }

    func updateNote(for id: Int, rating: Int, comment: String?, favorite: Bool) {
        localStorage.updateState(for: id, isFavorite: favorite, rating: rating, comment: comment)
    }

    func getNote(for id: Int) -> UserArticleState {
        return localStorage.state(for: id)
    }
}

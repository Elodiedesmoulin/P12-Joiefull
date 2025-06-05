//
//  ArticleRepository.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation

final class ArticleRepository: ArticleRepositoryProtocol {
    static let shared = ArticleRepository()
    private let apiService: APIServiceProtocol = APIService.shared

    func fetchArticles() async throws -> [Article] {
        // Pour le local :
        return try await apiService.fetchLocal(endpoint: "clothes")
        

    }
}

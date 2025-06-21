//
//  ArticleRepository.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation
import Combine


final class ArticleRepository: ArticleRepositoryProtocol {
    static let shared = ArticleRepository()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

    func fetchArticles() async throws -> [Article] {
        return try await apiService.fetchLocal(endpoint: "clothes")
        
    }
}


extension ArticleRepository {
    func fetchArticlesPublisher() -> AnyPublisher<[Article], RepositoryError> {
        Future { promise in
            Task {
                do {
                    let result = try await self.fetchArticles()
                    promise(.success(result))
                } catch let error as RepositoryError {
                    promise(.failure(error))
                } catch {
                    promise(.failure(.networkError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

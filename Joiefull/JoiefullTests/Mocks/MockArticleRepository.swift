//
//  MockArticleRepository.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
import Combine
@testable import Joiefull

final class MockArticleRepository: ArticleRepositoryProtocol {
    // Permet d’injecter ce que tu veux dans tes tests
    var publisherToReturn: AnyPublisher<[Article], RepositoryError>?
    var articlesToReturn: [Article] = []

    func fetchArticles() async throws -> [Article] {
        articlesToReturn
    }

    func fetchArticlesPublisher() -> AnyPublisher<[Article], RepositoryError> {
        // Si le test a injecté un publisher, on l’utilise
        if let publisher = publisherToReturn {
            return publisher
        } else {
            // Par défaut : succès immédiat avec articlesToReturn
            return Just(articlesToReturn)
                .setFailureType(to: RepositoryError.self)
                .eraseToAnyPublisher()
        }
    }
}

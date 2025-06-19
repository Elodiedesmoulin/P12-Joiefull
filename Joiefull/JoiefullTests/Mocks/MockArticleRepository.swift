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
    var publisherToReturn: AnyPublisher<[Article], RepositoryError>?
    var articlesToReturn: [Article] = []

    func fetchArticles() async throws -> [Article] {
        articlesToReturn
    }

    func fetchArticlesPublisher() -> AnyPublisher<[Article], RepositoryError> {
        if let publisher = publisherToReturn {
            return publisher
        } else {
            return Just(articlesToReturn)
                .setFailureType(to: RepositoryError.self)
                .eraseToAnyPublisher()
        }
    }
}

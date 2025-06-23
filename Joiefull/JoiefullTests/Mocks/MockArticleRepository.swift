//
//  MockArticleRepository.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
@testable import Joiefull

final class MockArticleRepository: ArticleRepositoryProtocol {
    var articlesToReturn: [Article] = []
    var errorToThrow: Error?

    func fetchArticles() async throws -> [Article] {
        if let error = errorToThrow { throw error }
        return articlesToReturn
    }
}

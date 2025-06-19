//
//  APIServiceTests.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
@testable import Joiefull

final class APIServiceTests: XCTestCase {
    func testFetchLocalFileNotFoundThrows() {
        XCTAssertThrowsError(try APIService.shared.fetchLocal(endpoint: "fileNotFound") as [Article]) { error in
            XCTAssertEqual(error as? RepositoryError, .invalidURL)
        }
    }
    
    func testFetchLocalInvalidFileThrows() {
        XCTAssertThrowsError(try APIService.shared.fetchLocal(endpoint: "invalidArticles") as [Article]) { error in
            XCTAssertEqual(error as? RepositoryError, .decodingError)
        }
    }

    func testFetchLocalValidArticlesFile() throws {
        let articles: [Article] = try APIService.shared.fetchLocal(endpoint: "testArticles")
        XCTAssertEqual(articles.count, 1)
        XCTAssertEqual(articles.first?.name, "TEST")
        XCTAssertEqual(articles.first?.id, 42)
    }
}

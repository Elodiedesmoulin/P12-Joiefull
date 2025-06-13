//
//  APIServiceTests.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
@testable import Joiefull

final class APIServiceTests: XCTestCase {
    func testFetchLocalInvalidFileThrows() {
        XCTAssertThrowsError(try APIService.shared.fetchLocal(endpoint: "fileNotFound") as [Article])
    }
    
    func testDecodingArticle() throws {
        let json = """
        [
          {
            "id": 1,
            "picture": { "url": "u", "description": "desc" },
            "name": "A",
            "category": "TOPS",
            "price": 1.0,
            "original_price": 1.0,
            "likes": 1
          }
        ]
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let articles = try decoder.decode([Article].self, from: json)
        XCTAssertEqual(articles.first?.name, "A")
    }
}

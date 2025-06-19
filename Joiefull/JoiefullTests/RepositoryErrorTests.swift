//
//  RepositoryErrorTests.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
import Combine
@testable import Joiefull

final class RepositoryErrorTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testErrorDescriptions() {
        XCTAssertEqual(RepositoryError.invalidURL.errorDescription, "URL invalide")
        XCTAssertEqual(RepositoryError.networkError.errorDescription, "Erreur réseau")
        XCTAssertEqual(RepositoryError.decodingError.errorDescription, "Erreur de décodage des données")
    }
    
    func testFetchArticlesPublisherEmitsInvalidURLError() {
        let mockService = MockAPIService()
        mockService.errorToThrow = RepositoryError.invalidURL
        let repo = ArticleRepository(apiService: mockService)
        let expectation = XCTestExpectation(description: "invalidURL Error recieved via Combine")
        
        repo.fetchArticlesPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidURL)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchArticlesPublisherEmitsNetworkError() {
        let mockService = MockAPIService()
        mockService.errorToThrow = RepositoryError.networkError
        let repo = ArticleRepository(apiService: mockService)
        let expectation = XCTestExpectation(description: "networkError recieved via Combine")
        
        repo.fetchArticlesPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .networkError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchArticlesPublisherEmitsDecodingError() {
        let mockService = MockAPIService()
        mockService.errorToThrow = RepositoryError.decodingError
        let repo = ArticleRepository(apiService: mockService)
        let expectation = XCTestExpectation(description: "decodingError recieved via Combine")
        
        repo.fetchArticlesPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .decodingError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}

//
//  MockAPIService.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
@testable import Joiefull

final class MockAPIService: APIServiceProtocol {
    var dataToReturn: Any?
    var errorToThrow: Error?

    func fetchLocal<T>(endpoint: String) throws -> T where T : Decodable {
        if let error = errorToThrow { throw error }
        guard let value = dataToReturn as? T else {
            throw RepositoryError.decodingError
        }
        return value
    }
}
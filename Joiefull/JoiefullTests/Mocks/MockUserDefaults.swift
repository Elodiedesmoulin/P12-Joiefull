//
//  MockUserDefaults.swift
//  Joiefull
//
//  Created by Elo on 13/06/2025.
//


import XCTest
@testable import Joiefull

final class MockUserDefaults: UserDefaultsProtocol {
    var storage: [String: Any] = [:]

    func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }
}

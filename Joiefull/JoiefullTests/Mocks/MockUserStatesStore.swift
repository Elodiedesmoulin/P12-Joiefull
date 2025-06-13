//
//  MockUserStatesStore.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//


import XCTest
@testable import Joiefull

final class MockUserStatesStore: UserStatesStoreProtocol {
    var savedStates: [Int: UserArticleState] = [:]
    func save(states: [Int : UserArticleState]) { savedStates = states }
    func load() -> [Int : UserArticleState] { savedStates }
}



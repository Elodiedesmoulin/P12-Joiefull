//
//  UserStatesStore.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func data(forKey defaultName: String) -> Data?
}

extension UserDefaults: UserDefaultsProtocol {
    
}

final class UserStatesStore: UserStatesStoreProtocol {
    private let userStatesKey = "UserArticleStates"
    private let userDefaults: UserDefaultsProtocol

    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func save(states: [Int: UserArticleState]) {
        if let data = try? JSONEncoder().encode(states) {
            userDefaults.set(data, forKey: userStatesKey)
        }
    }

    func load() -> [Int: UserArticleState] {
        guard let data = userDefaults.data(forKey: userStatesKey),
              let savedStates = try? JSONDecoder().decode([Int: UserArticleState].self, from: data) else {
            return [:]
        }
        return savedStates
    }
}


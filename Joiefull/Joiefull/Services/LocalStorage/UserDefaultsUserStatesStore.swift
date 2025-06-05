//
//  UserDefaultsUserStatesStore.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation

final class UserDefaultsUserStatesStore: UserStatesStoreProtocol {
    private let userStatesKey = "UserArticleStates"

    func save(states: [Int: UserArticleState]) {
        if let data = try? JSONEncoder().encode(states) {
            UserDefaults.standard.set(data, forKey: userStatesKey)
        }
    }

    func load() -> [Int: UserArticleState] {
        guard let data = UserDefaults.standard.data(forKey: userStatesKey),
              let savedStates = try? JSONDecoder().decode([Int: UserArticleState].self, from: data) else {
            return [:]
        }
        return savedStates
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: userStatesKey)
    }
}


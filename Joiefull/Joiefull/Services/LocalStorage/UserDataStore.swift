//
//  UserDataStore.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation


final class UserDataStore: UserDataStoreProtocol {
    static let shared = UserDataStore()

    private let key = "userArticleStates"
    private var states: [Int: UserArticleState] = [:]

    private init() {
        load()
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Int: UserArticleState].self, from: data) {
            self.states = decoded
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(states) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func state(for articleID: Int) -> UserArticleState {
        states[articleID] ?? UserArticleState(isFavorite: false, rating: 0, comment: "")
    }

    func updateState(for articleID: Int, isFavorite: Bool? = nil, rating: Int? = nil, comment: String? = nil) {
        var current = state(for: articleID)
        if let isFavorite = isFavorite {
            current.isFavorite = isFavorite
        }
        if let rating = rating {
            current.rating = rating
        }
        if let comment = comment {
            current.comment = comment
        }
        states[articleID] = current
        save()
    }
}

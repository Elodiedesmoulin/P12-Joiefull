//
//  UserArticleState.swift
//  Joiefull
//
//  Created by Elo on 23/05/2025.
//


import Foundation

final class UserDataStore {
    static let shared = UserDataStore()
    private let key = "userArticleStates"

    private init() {}

    private var states: [Int: UserArticleState] = [:]

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
        states[articleID] ?? UserArticleState(isFavorite: false, rating: 0)
    }

    func updateState(for articleID: Int, isFavorite: Bool? = nil, rating: Int? = nil) {
        var current = states[articleID] ?? UserArticleState(isFavorite: false, rating: 0)
        if let isFavorite = isFavorite { current.isFavorite = isFavorite }
        if let rating = rating { current.rating = rating }
        states[articleID] = current
        save()
    }
}

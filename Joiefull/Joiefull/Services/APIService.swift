//
//  APIService.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

final class APIService {
    static func loadArticles() -> [Article] {
        guard let url = Bundle.main.url(forResource: "clothes", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Article].self, from: data) else {
            print("Error during loading of clothes.json")
            return []
        }

        return decoded
    }
}
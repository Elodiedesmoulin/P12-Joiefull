//
//  Article.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

struct Article: Identifiable, Codable, Equatable {
    let id: Int
    let picture: Picture
    let name: String
    let category: String
    let price: Double
    let originalPrice: Double
    var likes: Int
}

extension Article {
    var ratingString: String {

        let ratings: [Int: Double] = [
            0: 4.3, 1: 4.4, 2: 4.2, 3: 4.6, 4: 4.6, 5: 4.2, 6: 4.1, 7: 4.1, 8: 4.1, 9: 4.1, 10: 4.1, 11: 4.1
        ]
        return String(format: "%.1f", ratings[self.id] ?? 4.1)
    }
}

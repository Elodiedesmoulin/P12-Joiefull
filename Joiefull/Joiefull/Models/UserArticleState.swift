//
//  UserArticleState.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

struct UserArticleState: Codable, Equatable {
    var isFavorite: Bool = false
    var userRating: Int? = nil
    var userComment: String? = nil
}


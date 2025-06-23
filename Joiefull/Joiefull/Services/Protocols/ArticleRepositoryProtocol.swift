//
//  ArticleRepositoryProtocol.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation
import Combine

protocol ArticleRepositoryProtocol {
    func fetchArticles() async throws -> [Article]
}

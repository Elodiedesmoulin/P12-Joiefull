//
//  ArticleServiceProtocol.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation

protocol ArticleServiceProtocol {
    func fetchArticles() async -> Result<[Article], ArticleServiceError>
}


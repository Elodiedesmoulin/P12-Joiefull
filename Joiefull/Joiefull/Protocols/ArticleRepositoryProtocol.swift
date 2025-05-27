//
//  ArticleRepositoryProtocol.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation


protocol ArticleRepositoryProtocol {
    func fetchArticles() async -> Result<[RatedArticle], ArticleServiceError>
    func updateNote(for id: Int, rating: Int, comment: String?, favorite: Bool)
    func getNote(for id: Int) -> UserArticleState
}

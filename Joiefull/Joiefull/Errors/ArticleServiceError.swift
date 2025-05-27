//
//  ArticleServiceError.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation


enum ArticleServiceError: Error {
    case invalidURL
    case decodingFailed
    case network(Error)
    case unknown
}

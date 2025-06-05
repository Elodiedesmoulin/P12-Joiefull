//
//  RepositoryError.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import Foundation

enum RepositoryError: Error, LocalizedError {
    case invalidURL
    case networkError
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "URL invalide"
        case .networkError: return "Erreur réseau"
        case .decodingError: return "Erreur de décodage des données"
        }
    }
}

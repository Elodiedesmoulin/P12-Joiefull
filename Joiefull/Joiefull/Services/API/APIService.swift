//
//  APIService.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

final class APIService: APIServiceProtocol {
    static let shared = APIService()
    
    func fetchLocal<T: Decodable>(endpoint: String) throws -> T {
        guard let url = Bundle.main.url(forResource: endpoint, withExtension: "json") else {
            throw RepositoryError.invalidURL
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    
    
    
    
    
//    private let baseURL = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/"

//    func fetch<T: Decodable>(endpoint: String) async throws -> T {
//        guard let url = URL(string: baseURL + endpoint) else {
//            throw RepositoryError.invalidURL
//        }
//        let (data, _) = try await URLSession.shared.data(from: url)
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let decoded = try decoder.decode(T.self, from: data)
//            return decoded
//        } catch {
//            throw RepositoryError.decodingError
//        }
//    }
    
    // For POST/PUT later :
//    func post<T: Codable, U: Decodable>(endpoint: String, body: T) async throws -> U {
//        guard let url = URL(string: baseURL + endpoint) else {
//            throw RepositoryError.invalidURL
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = try JSONEncoder().encode(body)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let (data, _) = try await URLSession.shared.data(for: request)
//        do {
//            let decoded = try JSONDecoder().decode(U.self, from: data)
//            return decoded
//        } catch {
//            throw RepositoryError.decodingError
//        }
//    }
}

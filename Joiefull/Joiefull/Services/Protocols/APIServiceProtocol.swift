//
//  APIServiceProtocol.swift
//  Joiefull
//
//  Created by Elo on 05/06/2025.
//


import Foundation


protocol APIServiceProtocol {
    func fetchLocal<T: Decodable>(endpoint: String) async throws -> T
}

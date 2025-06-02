//
//  UserDataStoreProtocol.swift
//  Joiefull
//
//  Created by Elo on 02/06/2025.
//


import Foundation


protocol UserDataStoreProtocol {
    func state(for articleID: Int) -> UserArticleState
    func updateState(for articleID: Int, isFavorite: Bool?, rating: Int?, comment: String?)
    func load()
    func save()
}

//
//  UserStatesStoreProtocol.swift
//  Joiefull
//
//  Created by Elo on 02/06/2025.
//


import Foundation

protocol UserStatesStoreProtocol {
    func save(states: [Int: UserArticleState])
    func load() -> [Int: UserArticleState]
}

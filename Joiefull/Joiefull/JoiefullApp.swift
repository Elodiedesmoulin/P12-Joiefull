//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI

@main
struct P12_JoiefullApp: App {
    @StateObject var articleListViewModel = ArticleListViewModel()
        var body: some Scene {
            WindowGroup {
                HomeView()
                    .environmentObject(articleListViewModel)
            }
        }
    }

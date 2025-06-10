//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI

@main
struct JoiefullApp: App {
    @StateObject var articleListViewModel = ArticleListViewModel()
        var body: some Scene {
            WindowGroup {
                AppMainView()
                    .environmentObject(articleListViewModel)
            }
        }
    }

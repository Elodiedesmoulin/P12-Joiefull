//
//  AppMainView.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//

import SwiftUI

struct AppMainView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    @State private var selectedArticle: Article? = nil

    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if selectedArticle != nil {
                    iPadSplitView(selectedArticle: $selectedArticle)
                } else {
                    HomeiPadView(selectedArticle: $selectedArticle)
                }
            } else {
                HomeView()
            }
        }
        .environmentObject(viewModel)
        .onAppear { Task { await viewModel.loadArticles() } }
    }
}

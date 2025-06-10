//
//  HomeView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    ForEach(viewModel.categoriesSorted(), id: \.self) { category in
                        ArticleSectionView(category: category)
                    }
                }
                .padding(.top, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
            .onAppear { Task { await viewModel.loadArticles() } }
        }
    }
}

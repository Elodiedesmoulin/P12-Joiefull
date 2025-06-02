//
//  HomeView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                content
            }
            .navigationTitle("Home")
            .onAppear {
                viewModel.loadArticles()
            }
        }
    }

    private var content: some View {
        LazyVStack(alignment: .leading, spacing: 32) {
            ForEach(viewModel.groupedArticles.keys.sorted(), id: \.self) { category in
                section(for: category)
            }
        }
        .padding(.top)
    }

    @ViewBuilder
    private func section(for category: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.localizedCategory(category))
                .font(.title2.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.groupedArticles[category] ?? []) { ratedArticle in
                        NavigationLink(destination: DetailView(ratedArticle: ratedArticle, refreshID: UUID())) {
                            ArticleCardView(ratedArticle: ratedArticle)
                                .frame(width: 200)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView()
}

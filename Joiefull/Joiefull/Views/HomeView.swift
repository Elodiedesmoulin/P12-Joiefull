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
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    ForEach(viewModel.groupedArticles.keys.sorted(), id: \ .self) { category in
                        VStack(alignment: .leading) {
                            Text(viewModel.localizedCategory(category))
                                .font(.title2.bold())
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(viewModel.groupedArticles[category] ?? []) { ratedArticle in
                                        NavigationLink(destination: DetailView(ratedArticle: ratedArticle)) {
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
                .padding(.top)
            }
            .navigationTitle("Home")
            .onAppear {
                viewModel.loadArticles()
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  ContentView.swift
//  Joiefull
//
//  Created by Elo on 05/06/2025.
//


import SwiftUI

//struct ContentView: View {
//    @StateObject private var viewModel = ArticleListViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.articles) { article in
//                ArticleRow(
//                    article: article,
//                    isFavorite: viewModel.isFavorite(article),
//                    rating: viewModel.userRating(for: article),
//                    comment: viewModel.userComment(for: article),
//                    onFavoriteToggle: { viewModel.toggleFavorite(for: article) },
//                    onRatingChange: { newRating in viewModel.setRating(for: article, rating: newRating) },
//                    onCommentChange: { newComment in viewModel.setComment(for: article, comment: newComment) }
//                )
//            }
//            .navigationTitle("Articles")
//            .onAppear {
//                Task { await viewModel.loadArticles() }
//            }
//        }
//    }
//}

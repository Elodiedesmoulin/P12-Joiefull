//
//  DetailView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI


struct DetailView: View {
    @ObservedObject var ratedArticle: RatedArticle
    @StateObject private var viewModel: DetailViewModel
    @State private var isFavorite: Bool

    init(ratedArticle: RatedArticle, refreshID: UUID) {
        self.ratedArticle = ratedArticle
        _viewModel = StateObject(wrappedValue: DetailViewModel(article: ratedArticle.article))
        _isFavorite = State(initialValue: ratedArticle.isFavorite)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HeaderImageView(article: ratedArticle.article, isFavorite: $isFavorite, onShare: {
                    viewModel.shareArticle()
                })

                ArticleInfoView(article: ratedArticle.article, rating: ratedArticle.rating)

                RatingAndCommentView(ratedArticle: ratedArticle, viewModel: viewModel)

                Spacer()
            }
            .padding()
        }
        .onTapGesture { hideKeyboard() }
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.updateComment()
        }
    }
}

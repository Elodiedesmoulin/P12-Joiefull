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
    @State private var userComment: String = ""
    @State private var isFavorite: Bool

    init(ratedArticle: RatedArticle) {
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

                RatingAndCommentView(ratedArticle: ratedArticle, userComment: $userComment)
                
                Spacer()
            }
            .padding()
        }
        .onTapGesture { hideKeyboard() }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DetailView(ratedArticle: RatedArticle(article:  Article(
//        id: 1,
//        picture: .init(url: "https://example.com", description: "Image"),
//        name: "Jean slim",
//        category: "BOTTOMS",
//        likes: 20,
//        price: 49.0,
//        original_price: 65.0
//    ), rating: 1.2))
//}

//
//  DetailView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import SwiftUI

struct DetailView: View {
    let article: Article
    @EnvironmentObject var viewModel: ArticleListViewModel
    @State private var showShareSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Spacer()
                    ArticleImageWithLikesView(
                        imageUrl: article.picture.url,
                        likes: article.likes,
                        isFavorite: viewModel.isFavorite(article),
                        onToggleFavorite: { viewModel.toggleFavorite(for: article) },
                        width: UIScreen.main.bounds.width - 30,
                        height: 400
                    )
                    Spacer()
                }
                .padding(.top, 12)

                VStack(alignment: .leading, spacing: 12) {
                    ArticleTitleRatingView(
                        name: article.name,
                        ratingString: article.ratingString
                    )
                    .font(.title2)
                    ArticlePriceView(
                        price: article.price,
                        originalPrice: article.originalPrice
                    )
                    .font(.title2)
                    Text(article.picture.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                        StarRatingView(
                            rating: Binding(
                                get: { viewModel.userRating(for: article)},
                                set: { viewModel.setRating(for: article, rating: $0) }
                            )
                        )
                    }
                    .padding(.vertical, 6)
                    ZStack(alignment: .topLeading) {
                        TextEditor(
                            text: Binding(
                                get: { viewModel.userComment(for: article) },
                                set: { viewModel.setComment(for: article, comment: $0) }
                            )
                        )
                        .frame(minHeight: 120, maxHeight: 130)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .font(.body)
                        if (viewModel.userComment(for: article)).isEmpty {
                            Text("Partagez ici vos impressions sur cette pièce")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                        }
                    }
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 26)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

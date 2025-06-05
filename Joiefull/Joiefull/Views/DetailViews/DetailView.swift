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
            VStack(alignment: .leading, spacing: 18) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: article.picture.url)) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .frame(height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Button {
                        showShareSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black)
                            .padding(12)
                            .background(.white.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding()
                    .sheet(isPresented: $showShareSheet) {
                        if let url = URL(string: article.picture.url) {
                            ShareSheet(items: [url])
                        }
                    }
                }

                HStack {
                    Text(article.name)
                        .font(.title2.bold())
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(article.ratingString)
                            .font(.body.bold())
                    }
                }

                HStack(spacing: 14) {
                    Text("\(Int(article.price))€")
                        .font(.title2.bold())
                    if article.price < article.originalPrice {
                        Text("\(Int(article.originalPrice))€")
                            .strikethrough()
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: { viewModel.toggleFavorite(for: article) }) {
                        Image(systemName: viewModel.isFavorite(article) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite(article) ? .red : .gray)
                            .font(.title2)
                    }
                }

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
                            get: { viewModel.userRating(for: article) ?? 0 },
                            set: { viewModel.setRating(for: article, rating: $0) }
                        )
                    )
                }
                .padding(.vertical, 6)

                TextField(
                    "Partagez ici vos impressions sur cette pièce",
                    text: Binding(
                        get: { viewModel.userComment(for: article) ?? "" },
                        set: { viewModel.setComment(for: article, comment: $0) }
                    )
                )
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .font(.body)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 18)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//  ArticleCardView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import SwiftUI

struct ArticleCardView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: article.picture.url)) { image in
                    image.resizable().aspectRatio(1, contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(height: 145)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                Button(action: { viewModel.toggleFavorite(for: article) }) {
                    HStack(spacing: 6) {
                        Image(systemName: viewModel.isFavorite(article) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite(article) ? .red : .gray)
                        Text("\(article.likes)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(radius: 1)
                }
                .padding(8)
            }
            .frame(height: 145)

            Text(article.name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(1)

            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 14))
                Text(article.ratingString)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                if article.price < article.originalPrice {
                    Text("\(Int(article.originalPrice))€")
                        .strikethrough()
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
            }
            Text("\(Int(article.price))€")
                .font(.system(size: 17, weight: .bold))
        }
        .padding(.vertical, 2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

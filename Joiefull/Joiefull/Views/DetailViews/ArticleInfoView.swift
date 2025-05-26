//
//  ArticleInfoView.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import SwiftUI


struct ArticleInfoView: View {
    let article: Article
    let rating: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(article.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .font(.subheadline)
                Text(String(format: "%.1f", rating))
                    .font(.subheadline)
                    .fontWeight(.semibold)

            }

            HStack(spacing: 8) {
                Text("\(article.price, specifier: "%.0f")€")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                if article.original_price > article.price {
                    Text("\(article.original_price, specifier: "%.0f")€")
                        .strikethrough()
                        .foregroundColor(.gray)
                }
            }

            Text(article.picture.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

//
//  ArticleCardView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import SwiftUI

struct ArticleCardView: View {
    let ratedArticle: RatedArticle

    var body: some View {
        let article = ratedArticle.article
        
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: article.picture.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 180)
            .clipped()
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(article.name)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.subheadline)
                    Text(String(format: "%.1f", ratedArticle.rating))
                        .font(.subheadline)
                }
                
                HStack(spacing: 8) {
                    Text("\(article.price, specifier: "%.0f")€")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    if article.original_price > article.price {
                        Text("\(article.original_price, specifier: "%.0f")€")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .strikethrough()
                    }
                }
            }
        }
    }
}

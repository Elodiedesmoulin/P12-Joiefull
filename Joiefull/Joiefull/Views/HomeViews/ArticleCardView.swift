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
    var isSelected: Bool = false

    
    var body: some View {
        VStack(alignment: .leading) {
            
            ArticleImageWithLikesView(
                imageUrl: article.picture.url,
                likes: article.likes,
                isFavorite: viewModel.isFavorite(article),
                onToggleFavorite: { viewModel.toggleFavorite(for: article) }
            )
            
            ArticleTitleRatingView(
                name: article.name,
                ratingString: article.ratingString
            )
            .padding(.horizontal, 2)
            
            ArticlePriceView(
                price: article.price,
                originalPrice: article.originalPrice
            )
            .padding(.horizontal, 2)
            .padding(.top, -4)
        }
        .padding(6)
        .frame(width: 180, alignment: .leading)
        .accessibilityElement(children: .combine)
                .accessibilityLabel("\(article.name), \(article.ratingString) étoiles, \(Int(article.price)) euros")
    }
}





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
    var width: CGFloat
    var height: CGFloat
    var trailingPadding: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            ArticleImageWithLikesView(
                imageUrl: article.picture.url,
                likes: viewModel.displayLikes(for: article),
                isFavorite: viewModel.isFavorite(article),
                onToggleFavorite: { viewModel.toggleFavorite(for: article) },
                width: width,
                height: height
            )
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(isSelected ? Color.cyan : Color.clear, lineWidth: isSelected ? 3 : 0)
            )
            ArticleTitleRatingView(
                name: article.name,
                ratingString: article.ratingString,
                trailingPadding: trailingPadding
            )
            ArticlePriceView(
                price: article.price,
                originalPrice: article.originalPrice
            )
        }
        .padding(6)
        .frame(width: 190, alignment: .leading)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(articleAccessibilityLabel)
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
        .accessibilityHint("Double tap pour afficher le détail de la pièce.")
    }

    var articleAccessibilityLabel: String {
        var label = "\(article.name), \(Int(article.price)) euros"
        label += "Photo de \(article.picture.description)"
        if article.price < article.originalPrice {
            label += ", en promotion, ancien prix \(Int(article.originalPrice)) euros"
        }
        if viewModel.isFavorite(article) {
            label += ", enlevé des favoris"
        } else {
            label += ", ajouté aux favoris"
        }
        label += ", \(article.likes) personnes aiment cet article"
        label += ", note \(article.ratingString) sur 5"
        return label
    }
}






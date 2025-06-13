//
//  ArticleSectionHorizontalView.swift
//  Joiefull
//
//  Created by Elo on 11/06/2025.
//


import SwiftUI

struct ArticleSectionHorizontalView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    let category: String
    let selectedArticle: Article?
    let onSelect: (Article) -> Void

    var articles: [Article] {
        let filtered = viewModel.articles.filter { $0.category == category }
        
        return filtered
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.label(for: category))
                .font(.title.bold())
                .padding(.leading, 18)
                .padding(.bottom, 2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(articles) { article in
                        ArticleCardView(
                            article: article,
                            isSelected: selectedArticle?.id == article.id
                        )
                        .onTapGesture {
                            onSelect(article)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }
}

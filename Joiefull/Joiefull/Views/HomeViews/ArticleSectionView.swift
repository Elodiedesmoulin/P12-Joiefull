//
//  ArticleSectionView.swift
//  Joiefull
//
//  Created by Elo on 05/06/2025.
//


import SwiftUI

struct ArticleSectionView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    let category: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeaderView(title: viewModel.label(for: category))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.articles.filter { $0.category == category }) { article in
                        NavigationLink(destination: DetailView(article: article)) {
                            ArticleCardView(article: article)
                                .frame(width: 180)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.horizontal, 6)
            }
        }
    }
}

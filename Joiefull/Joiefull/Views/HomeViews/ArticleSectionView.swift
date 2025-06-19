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
    var width: CGFloat
    var height: CGFloat
    var trailingPadding: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            SectionHeaderView(title: viewModel.label(for: category))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.articles.filter { $0.category == category }) { article in
                        NavigationLink(destination: DetailView(article: article)) {
                            ArticleCardView(article: article, width: width, height: height,trailingPadding: trailingPadding)
                                .frame(width: 180)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.horizontal, 6)
            }
        }
    }
}

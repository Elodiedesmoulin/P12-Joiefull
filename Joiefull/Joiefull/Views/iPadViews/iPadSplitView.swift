//
//  iPadSplitView.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//


import SwiftUI

struct iPadSplitView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        ForEach(viewModel.categoriesSorted(), id: \.self) { category in
                            ArticleSectionHorizontalView(
                                category: category,
                                selectedArticle: selectedArticle,
                                onSelect: { article in
                                    withAnimation { selectedArticle = article }
                                }
                            )
                        }
                    }
                    .padding(.top, 16)
                }
                .frame(width: geo.size.width * 0.6, alignment: .leading)
                .background(Color(.systemGroupedBackground))
                
                Divider()
                
                if let article = selectedArticle {
                    DetailView(article: article, maxWidth: geo.size.width * 0.3)
                        .frame(width: geo.size.width * 0.4)
                        .background(Color(.systemBackground))
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: selectedArticle)
        }
    }
}

//
//  HomeiPadView.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//


import SwiftUI

struct HomeiPadView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
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
        .background(Color(.systemGroupedBackground))
        .transition(.identity)
    }
}

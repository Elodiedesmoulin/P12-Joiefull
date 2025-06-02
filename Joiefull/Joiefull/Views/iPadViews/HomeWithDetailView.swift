//
//  HomeWithDetailView.swift
//  Joiefull
//
//  Created by Elo on 27/05/2025.
//


import SwiftUI


struct HomeWithDetailView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedArticle: RatedArticle?
    @State private var refreshID = UUID()

    var body: some View {
        HStack(spacing: 0) {
            HomeGridView(viewModel: viewModel, selectedArticle: $selectedArticle, refreshID: $refreshID)
                .frame(width: selectedArticle == nil ? UIScreen.main.bounds.width : UIScreen.main.bounds.width * 0.60)
                .background(Color(.systemGray6))

            if let article = selectedArticle {
                Divider()

                DetailView(ratedArticle: article, refreshID: UUID())
                    .id(refreshID)
                    .frame(width: UIScreen.main.bounds.width * 0.40)
                    .transition(.move(edge: .trailing))
            }
        }
        .onAppear {
            viewModel.loadArticles()
        }
        .onChange(of: selectedArticle?.id) { _ in
            refreshID = UUID()
        }
    }
}



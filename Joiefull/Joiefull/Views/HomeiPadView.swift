//
//  HomeGridView.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//


import SwiftUI

struct HomeiPadView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
        @Binding var selectedArticle: Article?

        var body: some View {
            ZStack {
                // HomeView occupe tout l'écran tant que rien n'est sélectionné
                if selectedArticle == nil {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 32) {
                            ForEach(viewModel.categoriesSorted(), id: \.self) { category in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(viewModel.label(for: category))
                                        .font(.title.bold())
                                        .padding(.leading, 18)
                                        .padding(.bottom, 2)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 20) {
                                            ForEach(viewModel.articles.filter { $0.category == category }) { article in
                                                ArticleCardView(
                                                    article: article,
                                                    isSelected: false
                                                )
                                                .onTapGesture {
                                                    withAnimation { selectedArticle = article }
                                                }
                                                .accessibilityElement(children: .combine)
                                            }
                                        }
                                        .padding(.horizontal, 18)
                                    }
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                    .background(Color(.systemGroupedBackground))
                    .transition(.identity)
                } else {
                    // SplitView (HomeView à gauche réduit, DetailView à droite)
                    HStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 32) {
                                ForEach(viewModel.categoriesSorted(), id: \.self) { category in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(viewModel.label(for: category))
                                            .font(.title.bold())
                                            .padding(.leading, 18)
                                            .padding(.bottom, 2)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 20) {
                                                ForEach(viewModel.articles.filter { $0.category == category }) { article in
                                                    ArticleCardView(
                                                        article: article,
                                                        isSelected: selectedArticle?.id == article.id
                                                    )
                                                    .onTapGesture {
                                                        withAnimation { selectedArticle = article }
                                                    }
                                                    .accessibilityElement(children: .combine)
                                                }
                                            }
                                            .padding(.horizontal, 18)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 16)
                        }
                        .frame(minWidth: 480, maxWidth: 520)
                        .background(Color(.systemGroupedBackground))
                        .transition(.move(edge: .leading))
                        
                        Divider()

                        if let article = selectedArticle {
                            DetailView(article: article)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(.systemBackground))
                                .transition(.move(edge: .trailing))
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: selectedArticle)
        }
    }

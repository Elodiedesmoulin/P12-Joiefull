//
//  HomeGridView.swift
//  Joiefull
//
//  Created by Elo on 27/05/2025.
//


import SwiftUI


//struct HomeGridView: View {
//    @ObservedObject var viewModel: HomeViewModel
//    @Binding var selectedArticle: RatedArticle?
//    @Binding var refreshID: UUID
//
//    var columns: [GridItem] {
//        Array(repeating: GridItem(.flexible(), spacing: 20), count: selectedArticle == nil ? 5 : 3)
//    }
//
//    var body: some View {
//        ScrollView {
//            LazyVStack(alignment: .leading, spacing: 32) {
//                ForEach(viewModel.groupedArticles.keys.sorted(), id: \.self) { category in
//                    VStack(alignment: .leading) {
//                        Text(viewModel.localizedCategory(category))
//                            .font(.title2.bold())
//                            .padding(.horizontal)
//
//                        LazyVGrid(columns: columns, spacing: 20) {
//                            ForEach(viewModel.groupedArticles[category] ?? []) { ratedArticle in
//                                ArticleCardView(ratedArticle: ratedArticle)
//                                    .onTapGesture {
//                                        selectedArticle = ratedArticle
//                                    }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//            }
//            .padding(.top)
//        }
//        .id(refreshID)
//    }
//}


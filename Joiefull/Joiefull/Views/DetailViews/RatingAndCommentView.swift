//
//  RatingAndCommentView.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import SwiftUI


struct RatingAndCommentView: View {
    @ObservedObject var ratedArticle: RatedArticle
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                    .accessibilityHidden(true)

                HStack(spacing: 4) {
                    ForEach(1...5, id: \ .self) { index in
                        Image(systemName: index <= Int(ratedArticle.rating) ? "star.fill" : "star")
                            .foregroundColor(index <= Int(ratedArticle.rating) ? .orange : .gray)
                            .accessibilityLabel("Donner une note de \(index) étoiles")
                            .accessibilityAddTraits(.isButton)
                            .onTapGesture {
                                ratedArticle.rating = Double(index)
                                viewModel.updateNote(id: ratedArticle.article.id, rating: index, favorite: ratedArticle.isFavorite)
                            }
                    }
                }
                .font(.headline)
            }

            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.userComment)
                    .frame(height: 120)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .accessibilityLabel("Champ de commentaire. Partagez ici vos impressions sur cette pièce.")

                if viewModel.userComment.isEmpty {
                    Text("Partagez ici vos impressions sur cette pièce")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                }
            }
        }
    }
}

//
//  ArticleImageWithLikesView.swift
//  Joiefull
//
//  Created by Elo on 09/06/2025.
//


import SwiftUI

struct ArticleImageWithLikesView: View {
    let imageUrl: String
    let likes: Int
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    var onShare: (() -> Void)? = nil
    var width: CGFloat = 190
    var height: CGFloat = 190
    var cornerRadius: CGFloat = 24

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
                    .aspectRatio(3/4, contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } placeholder: {
                Color.gray.opacity(0.1)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
            .accessibilityHidden(true)

            if let onShare = onShare {
                Button(action: onShare) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.45))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(12)
                .accessibilityLabel("Partager cette pièce")
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: onToggleFavorite) {
                        HStack(spacing: 4) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                            Text("\(likes)")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(radius: 1)
                    }
                    .padding([.vertical,.horizontal], 12)
                    .accessibilityLabel(isFavorite ? "Retirer des favoris" : "Ajouter aux favoris")
                    .accessibilityHint("\(likes) personnes aiment cet article.")
                    .accessibilityValue(isFavorite ? "Dans favoris" : "Non favori")
                }
            }
        }
        .frame(width: width, height: height)
    }
}

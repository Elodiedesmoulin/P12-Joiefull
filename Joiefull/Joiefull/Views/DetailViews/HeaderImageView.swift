//
//  HeaderImageView.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import SwiftUI


struct HeaderImageView: View {
    let article: Article
    @Binding var isFavorite: Bool
    let onShare: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: article.picture.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 400)
            .clipped()
            .cornerRadius(12)
            .accessibilityLabel(article.picture.description)

            Button(action: onShare) {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.gray)
            }
            .padding(.top, 9)
            .padding(.trailing, 9)
            .accessibilityLabel("Partager l’article")

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .black)
                            .onTapGesture {
                                isFavorite.toggle()
                                UserDataStore.shared.updateState(for: article.id, isFavorite: isFavorite)
                            }
                            .accessibilityLabel(isFavorite ? "Retirer des favoris" : "Ajouter aux favoris")
                        Text("\(article.likes + (isFavorite ? 1 : 0))")
                            .foregroundColor(.black)
                    }
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(12)
                }
            }
        }
    }
}



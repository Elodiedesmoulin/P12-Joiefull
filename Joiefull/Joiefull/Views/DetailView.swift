//
//  DetailView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI


struct DetailView: View {
    let ratedArticle: RatedArticle
    @State private var userRating: Int = 0
    @State private var userComment: String = ""
    @State private var isFavorite: Bool

    init(ratedArticle: RatedArticle) {
        self.ratedArticle = ratedArticle
        _isFavorite = State(initialValue: ratedArticle.isFavorite)
    }
    
    var body: some View {
        let article = ratedArticle.article
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: article.picture.url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(height: 350)
                    .clipped()
                    .cornerRadius(12)
                    .accessibilityLabel(article.picture.description)

                    HStack(spacing: 4) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .onTapGesture {
                                isFavorite.toggle()
                            }

                        Text("\(article.likes + (isFavorite ? 1 : 0))")
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(12)
                    
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(article.name)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                            .font(.subheadline)
                        Text(String(format: "%.1f", ratedArticle.rating))
                            .font(.subheadline)
                    }

                    HStack(spacing: 8) {
                        Text("\(article.price, specifier: "%.0f")€")
                            .font(.title3)
                            .fontWeight(.semibold)

                        if article.original_price > article.price {
                            Text("\(article.original_price, specifier: "%.0f")€")
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }

                    Text(article.picture.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())

                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= userRating ? "star.fill" : "star")
                                    .foregroundColor((userRating != 0) ? .orange : .gray)
                                    .onTapGesture {
                                        userRating = index
                                    }
                            }
                        }
                        .font(.headline)
                    }

                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $userComment)
                            .frame(height: 120)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        if userComment.isEmpty {
                            Text("Partagez ici vos impressions sur cette pièce")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 20)
                                .allowsHitTesting(false)
                        }
                    }
                        
                    
                }

                Spacer()
            }
            .padding()
        }
    
    .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(ratedArticle: RatedArticle(article:  Article(
        id: 1,
        picture: .init(url: "https://example.com", description: "Image"),
        name: "Jean slim",
        category: "BOTTOMS",
        likes: 20,
        price: 49.0,
        original_price: 65.0
    ), rating: 1.2))
}

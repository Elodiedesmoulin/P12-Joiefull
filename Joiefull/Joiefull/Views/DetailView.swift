//
//  DetailView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI

import SwiftUI

struct DetailView: View {
    let article: Article
    @State private var userRating: Int = 0
    @State private var userComment: String = ""

    var body: some View {
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
                        Image(systemName: "heart")
                        Text("\(article.likes)")
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
                        Text("4.6")
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
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        userRating = index
                                    }
                            }
                        }
                        .font(.headline)
                    }

                    TextField("Partagez ici vos impressions sur cette pièce", text: $userComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 4)
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(article: Article(
        id: 1,
        picture: .init(url: "https://example.com", description: "Image"),
        name: "Jean slim",
        category: "BOTTOMS",
        likes: 20,
        price: 49.0,
        original_price: 65.0
    ))
}

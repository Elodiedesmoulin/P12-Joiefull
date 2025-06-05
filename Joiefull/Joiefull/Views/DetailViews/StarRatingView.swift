//
//  StarRatingView.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    let max = 5
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...max, id: \.self) { idx in
                Image(systemName: rating >= idx ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.orange)
                    .onTapGesture {
                        rating = idx
                    }
            }
        }
    }
}



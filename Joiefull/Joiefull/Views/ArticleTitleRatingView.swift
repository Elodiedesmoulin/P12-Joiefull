//
//  ArticleTitleRatingView.swift
//  Joiefull
//
//  Created by Elo on 09/06/2025.
//


import SwiftUI

struct ArticleTitleRatingView: View {
    let name: String
    let ratingString: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(1)
            Spacer()
            HStack(spacing: 2) { 
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 15))
                Text(ratingString)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.top, 2)
        .padding(.trailing, -10)
    }
}

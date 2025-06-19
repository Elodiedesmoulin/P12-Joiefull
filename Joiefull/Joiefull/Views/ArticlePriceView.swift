//
//  ArticlePriceView.swift
//  Joiefull
//
//  Created by Elo on 09/06/2025.
//


import SwiftUI

struct ArticlePriceView: View {
    let price: Double
    let originalPrice: Double

    var body: some View {
        HStack(spacing: 8) {
            Text("\(Int(price))€")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            if price < originalPrice {
                Text("\(Int(originalPrice))€")
                    .strikethrough()
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

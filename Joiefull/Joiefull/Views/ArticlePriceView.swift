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
                .accessibilityElement(children: .ignore)
                .accessibilityHint("Prix actuel de \(Int(price)) euros.")
            if price < originalPrice {
                Text("\(Int(originalPrice))€")
                    .strikethrough()
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .accessibilityElement(children: .ignore)
                    .accessibilityHint("Ancien prix, avant réduction, de \(Int(originalPrice)) euros.")

            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

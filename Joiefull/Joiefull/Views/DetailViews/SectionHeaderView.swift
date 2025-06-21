//
//  SectionHeaderView.swift
//  Joiefull
//
//  Created by Elo on 26/05/2025.
//


import SwiftUI

struct SectionHeaderView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 28, weight: .bold, design: .default))
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.bottom, 4)
            .accessibilityAddTraits(.isHeader)
            .accessibilityElement(children: .ignore)
            .accessibilityHint("Catégorie \(title)")
    }

}


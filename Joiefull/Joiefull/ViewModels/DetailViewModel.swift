//
//  DetailViewModel.swift
//  Joiefull
//
//  Created by Elo on 24/05/2025.
//


import SwiftUI

class DetailViewModel: ObservableObject {
    let article: Article

    init(article: Article) {
        self.article = article
    }

    func shareArticle() {
        let formattedPrice = String(format: "%.2f", article.price)
        let message = "\(article.name) – seulement \(formattedPrice)€ sur Joiefull !"

        if let url = URL(string: article.picture.url) {
            let activityVC = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        }
    }
}

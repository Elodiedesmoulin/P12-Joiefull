//
//  DetailViewModel.swift
//  Joiefull
//
//  Created by Elo on 24/05/2025.
//


import SwiftUI

class DetailViewModel: ObservableObject {
    let article: Article
    private let repository: ArticleRepositoryProtocol

    @Published var userComment: String {
        didSet {
            updateComment()
        }
    }
    init(article: Article, repository: ArticleRepositoryProtocol = ArticleRepository()) {
        self.article = article
        self.repository = repository
        self.userComment = repository.getNote(for: article.id).comment
    }

    func updateNote(id: Int, rating: Int, favorite: Bool) {
        repository.updateNote(for: id, rating: rating, comment: userComment, favorite: favorite)
    }

    func updateComment() {
        let currentState = repository.getNote(for: article.id)
        repository.updateNote(for: article.id, rating: currentState.rating, comment: userComment, favorite: currentState.isFavorite)
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

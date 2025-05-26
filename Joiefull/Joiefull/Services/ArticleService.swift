//
//  APIService.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//


import Foundation

class ArticleService: ArticleServiceProtocol {
    private let session: URLSession
    private let urlString: String

    init(urlString: String, session: URLSession = .shared) {
        self.urlString = urlString
        self.session = session
    }

    func fetchArticles() async -> Result<[Article], ArticleServiceError> {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await session.data(from: url)
            let articles = try JSONDecoder().decode([Article].self, from: data)
            return .success(articles)
        } catch let decodingError as DecodingError {
            return .failure(.decodingFailed)
        } catch {
            return .failure(.network(error))
        }
    }
}

extension ArticleService {
    static func fromLocalJSON(named fileName: String) -> ArticleService {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("\(fileName).json introuvable")
        }
        return ArticleService(urlString: url.absoluteString)
    }

    static func fromRemoteURL(_ urlString: String) -> ArticleService {
        ArticleService(urlString: urlString)
    }
}

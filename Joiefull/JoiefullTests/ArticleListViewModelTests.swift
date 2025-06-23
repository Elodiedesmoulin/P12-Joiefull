//
//  ArticleListViewModelTests.swift
//  Joiefull
//
//  Created by Elo on 11/06/2025.
//


import XCTest
@testable import Joiefull

@MainActor
final class ArticleListViewModelTests: XCTestCase {
    var viewModel: ArticleListViewModel!
    var mockStore: UserStatesStore!
    var mockRepo: MockArticleRepository!
    var article: Article!
    var article2: Article!

    override func setUp() {
        super.setUp()
        mockStore = UserStatesStore(userDefaults: MockUserDefaults())
        mockRepo = MockArticleRepository()
        article = Article(
            id: 1,
            picture: Picture(url: "url", description: "desc"),
            name: "T-shirt",
            category: "TOPS",
            price: 10,
            originalPrice: 15,
            likes: 5
        )
        article2 = Article(
            id: 2,
            picture: Picture(url: "url2", description: "desc2"),
            name: "Pantalon",
            category: "BOTTOMS",
            price: 20,
            originalPrice: 25,
            likes: 1
        )
    }

    func testLoadArticlesSuccess() async {
        let mockRepo = MockArticleRepository()
        let mockStore = UserStatesStore(userDefaults: MockUserDefaults())

        mockRepo.articlesToReturn = [article, article2]
        let viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)

        await viewModel.loadArticles()
        XCTAssertEqual(viewModel.articles.count, 2)
        XCTAssertEqual(viewModel.articles.first?.name, "T-shirt")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadArticlesRepositoryError() async {
        mockRepo.errorToThrow = RepositoryError.invalidURL
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        await viewModel.loadArticles()
        XCTAssertEqual(viewModel.articles.count, 0)
        XCTAssertEqual(viewModel.errorMessage, RepositoryError.invalidURL.errorDescription)
    }


    func testIsFavoriteAndToggleFavorite() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        XCTAssertFalse(viewModel.isFavorite(article))
        viewModel.toggleFavorite(for: article)
        XCTAssertTrue(viewModel.isFavorite(article))
        viewModel.toggleFavorite(for: article)
        XCTAssertFalse(viewModel.isFavorite(article))
    }

    func testDisplayLikesReflectsUserFavorite() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        let originalLikes = article.likes
        XCTAssertEqual(viewModel.displayLikes(for: article), originalLikes)
        viewModel.toggleFavorite(for: article)
        XCTAssertEqual(viewModel.displayLikes(for: article), originalLikes + 1)
        viewModel.toggleFavorite(for: article)
        XCTAssertEqual(viewModel.displayLikes(for: article), originalLikes)
    }

    func testUserRatingAndSetRating() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        XCTAssertEqual(viewModel.userRating(for: article), 0)
        viewModel.setRating(for: article, rating: 4)
        XCTAssertEqual(viewModel.userRating(for: article), 4)
        viewModel.setRating(for: article, rating: 2)
        XCTAssertEqual(viewModel.userRating(for: article), 2)
    }

    func testUserCommentAndSetComment() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        XCTAssertEqual(viewModel.userComment(for: article), "")
        viewModel.setComment(for: article, comment: "Très bien !")
        XCTAssertEqual(viewModel.userComment(for: article), "Très bien !")
        viewModel.setComment(for: article, comment: "Moyen")
        XCTAssertEqual(viewModel.userComment(for: article), "Moyen")
    }

    func testPersistUserStatesOnFavorite() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        viewModel.toggleFavorite(for: article)
        let persisted = mockStore.load()
        XCTAssertTrue(persisted[article.id]?.isFavorite ?? false)
    }

    func testPersistUserStatesOnRating() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        viewModel.setRating(for: article, rating: 3)
        let persisted = mockStore.load()
        XCTAssertEqual(persisted[article.id]?.userRating, 3)
    }

    func testPersistUserStatesOnComment() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        viewModel.setComment(for: article, comment: "Top")
        let persisted = mockStore.load()
        XCTAssertEqual(persisted[article.id]?.userComment, "Top")
    }

    func testCategoriesSortedAndLabel() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article, article2]
        let sorted = viewModel.categoriesSorted()
        XCTAssertTrue(sorted.contains("TOPS"))
        XCTAssertTrue(sorted.contains("BOTTOMS"))
        XCTAssertEqual(viewModel.label(for: "TOPS"), "Hauts")
        XCTAssertEqual(viewModel.label(for: "BOTTOMS"), "Bas")
        XCTAssertEqual(viewModel.label(for: "SHOES"), "Chaussures")
        XCTAssertEqual(viewModel.label(for: "ACCESSORIES"), "Sacs")
        XCTAssertEqual(viewModel.label(for: "RANDOM"), "Random")
    }

    func testUnknownArticleStateReturnsDefault() {
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        let unknown = Article(id: 999, picture: Picture(url: "", description: ""), name: "X", category: "SHOES", price: 1, originalPrice: 1, likes: 0)
        XCTAssertFalse(viewModel.isFavorite(unknown))
        XCTAssertEqual(viewModel.userRating(for: unknown), 0)
        XCTAssertEqual(viewModel.userComment(for: unknown), "")
    }

    func testInitWithLoadedStates() {
        let state = UserArticleState(isFavorite: true, userRating: 5, userComment: "Parfait")
        mockStore.save(states: [article.id: state])
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        viewModel.articles = [article]
        XCTAssertEqual(viewModel.userRating(for: article), 5)
        XCTAssertEqual(viewModel.userComment(for: article), "Parfait")
        XCTAssertTrue(viewModel.isFavorite(article))
    }
}

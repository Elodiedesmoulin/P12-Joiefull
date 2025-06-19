//
//  ArticleListViewModelTests.swift
//  Joiefull
//
//  Created by Elo on 11/06/2025.
//


import XCTest
@testable import Joiefull

final class ArticleListViewModelTests: XCTestCase {
    var viewModel: ArticleListViewModel!
    var mockStore = UserStatesStore(userDefaults: MockUserDefaults())
    var mockRepo: MockArticleRepository!
    var article: Article!
    var article2: Article!

    override func setUp() {
        super.setUp()
        mockRepo = MockArticleRepository()
        viewModel = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
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
        viewModel.articles = [article, article2]
    }

    func testIsFavoriteAndToggleFavorite() {
        XCTAssertFalse(viewModel.isFavorite(article))
        viewModel.toggleFavorite(for: article)
        XCTAssertTrue(viewModel.isFavorite(article))
        viewModel.toggleFavorite(for: article)
        XCTAssertFalse(viewModel.isFavorite(article))
    }

    func testToggleFavoriteLikesIncrementsAndDecrements() {
        let originalLikes = article.likes
        viewModel.toggleFavorite(for: article)
        XCTAssertEqual(viewModel.articles[0].likes, originalLikes + 1)
        viewModel.toggleFavorite(for: article)
        XCTAssertEqual(viewModel.articles[0].likes, originalLikes)
    }

    func testUserRatingAndSetRating() {
        XCTAssertEqual(viewModel.userRating(for: article), 0)
        viewModel.setRating(for: article, rating: 4)
        XCTAssertEqual(viewModel.userRating(for: article), 4)
        viewModel.setRating(for: article, rating: 2)
        XCTAssertEqual(viewModel.userRating(for: article), 2)
    }

    func testUserCommentAndSetComment() {
        XCTAssertEqual(viewModel.userComment(for: article), "")
        viewModel.setComment(for: article, comment: "Très bien !")
        XCTAssertEqual(viewModel.userComment(for: article), "Très bien !")
        viewModel.setComment(for: article, comment: "Moyen")
        XCTAssertEqual(viewModel.userComment(for: article), "Moyen")
    }

    func testPersistUserStatesOnFavorite() {
        viewModel.toggleFavorite(for: article)
        let persisted = mockStore.load()
        XCTAssertTrue(persisted[article.id]?.isFavorite ?? false)
    }

    func testPersistUserStatesOnRating() {
        viewModel.setRating(for: article, rating: 3)
        let persisted = mockStore.load()
        XCTAssertEqual(persisted[article.id]?.userRating, 3)
    }

    func testPersistUserStatesOnComment() {
        viewModel.setComment(for: article, comment: "Top")
        let persisted = mockStore.load()
        XCTAssertEqual(persisted[article.id]?.userComment, "Top")
    }

    func testCategoriesSortedAndLabel() {
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
        let unknown = Article(id: 999, picture: Picture(url: "", description: ""), name: "X", category: "SHOES", price: 1, originalPrice: 1, likes: 0)
        XCTAssertFalse(viewModel.isFavorite(unknown))
        XCTAssertEqual(viewModel.userRating(for: unknown), 0)
        XCTAssertEqual(viewModel.userComment(for: unknown), "")
    }

    func testInitWithLoadedStates() {
        let state = UserArticleState(isFavorite: true, userRating: 5, userComment: "Parfait")
        mockStore.save(states: [article.id: state])
        let newVM = ArticleListViewModel(userStatesStore: mockStore, articleRepository: mockRepo)
        XCTAssertEqual(newVM.userRating(for: article), 5)
        XCTAssertEqual(newVM.userComment(for: article), "Parfait")
        XCTAssertTrue(newVM.isFavorite(article))
    }
    
    
}

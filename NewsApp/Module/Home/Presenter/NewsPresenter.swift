//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

enum DataFetchPhase<T> {
    case loading
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

protocol NewsPresenterProtocol: AnyObject {
//    var interactor: NewsListInteractorProtocol? { get set }
    
    func loadArticles()
//    func loadArticles(for category: Category)
}

class NewsPresenter: NewsPresenterProtocol, ObservableObject {
    private let interactor: NewsListInteractorProtocol?
    
    @Published var phase = DataFetchPhase<[Article]>.loading
    @Published var selectedCategory: Category
    @Published var searchText: String
    
    init(interactor: NewsListInteractorProtocol, category: Category = .general, query: String = ""){
        self.interactor = NewsListInteractor()
        self.selectedCategory = category
        self.searchText = query
    }
    
//    func loadArticles() {
//        interactor?.fetchArticles { [weak self] result in
//            self?.handleFetchResult(result)
//        }
//    }
    
    func loadArticles() {
        interactor?.fetchArticles(from: selectedCategory, q: searchText) { [weak self] result in
            self?.handleFetchResult(result)
        }
    }
    
    private func handleFetchResult(_ result: Result<[Article], Error>) {
        switch result {
        case .success(let articles):
            phase = .success(articles)
        case .failure(let error):
            phase = .failure(error)
        }
    }
}


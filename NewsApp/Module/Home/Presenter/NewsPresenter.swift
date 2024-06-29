//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

enum DataFetchPhase<T> {
    case loading
    case success(T)
    case failure(Error)
}

protocol NewsPresenterProtocol: AnyObject {
    func loadArticles()
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
    
    func loadArticles() {
        interactor?.fetchArticles(from: selectedCategory, q: searchText) { [weak self] result in
            self?.handleFetchResult(result)
        }
    }
    
    private func handleFetchResult(_ result: Result<[Article], Error>) {
        DispatchQueue.main.async { [weak self] in
           switch result {
           case .success(let articles):
               
               self?.phase = .success(articles)
           case .failure(let error):
               self?.phase = .failure(error)
           }
       }
    }
}


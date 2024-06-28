//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

class NewsListPresenter: ObservableObject {
    @Published var articles: [Article] = []
    private let interactor: NewsListInteractor
    
    init(interactor: NewsListInteractor) {
        self.interactor = interactor
    }
    
    func fetchArticles() {
        interactor.fetchArticles { result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self.articles = articles
                }
            case .failure(let error):
                print("Error fetching articles: \(error)")
                // Handle error or show alert if needed
            }
        }
    }
}


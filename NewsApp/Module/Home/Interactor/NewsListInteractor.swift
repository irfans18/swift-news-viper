//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

protocol NewsListInteractorProtocol: AnyObject {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
    func fetchArticles(from category: Category, q: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

class NewsListInteractor: NewsListInteractorProtocol {
    var articleService: ArticleService

    init(articleService: ArticleService = .shared) {
        self.articleService = articleService
    }

    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        articleService.fetchArticles { result in
            switch result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchArticles(from category: Category = .general, q: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        Task {
            do {
                let articles = try await articleService.fetch(from: category, q: q)
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }
    }
}


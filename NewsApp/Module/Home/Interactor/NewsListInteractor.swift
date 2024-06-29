//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

protocol NewsListInteractorProtocol: AnyObject {
    func fetchArticles(from category: Category, q: String?, completion: @escaping (Result<[Article], Error>) -> Void)
}

class NewsListInteractor: NewsListInteractorProtocol {
    var articleService: ArticleService

    init(articleService: ArticleService = .shared) {
        self.articleService = articleService
    }

    func fetchArticles(from category: Category = .general, q: String?, completion: @escaping (Result<[Article], Error>) -> Void) {
        Task {
            do {
                var articles:[Article] = []
                if let query = q, !query.isEmpty {
                    articles = try await articleService.fetch(query: query)
                }else{
                    articles = try await articleService.fetch(from: category)
                }
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }
    }
}


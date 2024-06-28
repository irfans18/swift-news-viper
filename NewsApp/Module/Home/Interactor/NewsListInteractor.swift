//
//  NewsInteractor.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

protocol NewsListInteractor {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

class NewsListInteractorImpl: NewsListInteractor {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=71924fb9d84c47c7a3378670c6966b63") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(NewsApiResponse.self, from: data)
                    completion(.success(response.articles))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

//
//  ArticleService.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

struct ArticleService {
    static let shared = ArticleService()
    private init() {}

    private let apiKey = "71924fb9d84c47c7a3378670c6966b63"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=71924fb9d84c47c7a3378670c6966b63") else {
            completion(.failure(NSError(domain: "NewsListInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(APIResponse.self, from: data)
                    completion(.success(response.articles!))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetch(from category: Category) async throws -> [Article] {
        let url = generateUrl(from: category)
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let apiResponse = try jsonDecoder.decode(APIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "Error Occurred")
            }
        case 400...499:
            let apiResponse = try jsonDecoder.decode(APIResponse.self, from: data)
            throw generateError(description: apiResponse.message ?? "Client Error")
        default:
            throw generateError(description: "Server Error")
        }
    }

    private func generateError(code: Int = 1, description: String) -> Error {
        return NSError(domain: "ArticleService", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }

    private func generateUrl(from category: Category) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "category", value: category.rawValue)
        ]
        return components.url!
    }
}

//
//  Article.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()


struct Article {
    
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case publishedAt
        case author
        case description
        case urlToImage
    }

    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ‧ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}

extension Article {

    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "tesla", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        let apiResponse = try! jsonDecoder.decode(APIResponse.self, from: data)
        return apiResponse.articles ?? []
    }

}


struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

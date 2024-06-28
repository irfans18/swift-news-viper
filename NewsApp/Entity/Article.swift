//
//  Article.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    // Add more properties as needed
}

struct NewsApiResponse: Codable {
    let articles: [Article]
}

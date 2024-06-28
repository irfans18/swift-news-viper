//
//  NewsArticle.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

struct NewsArticle: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    // Add other properties as needed
}

struct NewsResponse: Codable {
    let articles: [NewsArticle]
}

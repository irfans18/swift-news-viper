//
//  News.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

struct News: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

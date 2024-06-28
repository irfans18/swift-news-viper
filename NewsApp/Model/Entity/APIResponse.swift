//
//  APIResponse.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import Foundation

struct APIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}

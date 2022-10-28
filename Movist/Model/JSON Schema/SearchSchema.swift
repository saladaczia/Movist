//
//  MovieData.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//


import Foundation

// MARK: - TrendingSchema
struct SearchSchema: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool?
    let id: Int
    let title: String
    let genreIDS: [Int]
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id, title
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
    }
}






//
//  TrendingSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import Foundation

// MARK: - TrendingSchema
struct TrendingSchema: Codable {
    let page: Int
    let results: [TrendingResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TrendingResult: Codable {
    
    
    let id: Int
    let title: String
    
    let originalTitle, posterPath: String
    
    let genreIDS: [Int]
    
    let releaseDate: String
    
    let voteAverage: Double
    

    enum CodingKeys: String, CodingKey {
        
        
        case id, title
        
        case originalTitle = "original_title"
       
        case posterPath = "poster_path"
        
        case genreIDS = "genre_ids"
        
        case releaseDate = "release_date"
        
        case voteAverage = "vote_average"
        
    }
}



enum TrendingOriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
}

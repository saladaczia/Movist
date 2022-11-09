//
//  CinemaSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//


import Foundation

// MARK: - TopSchema
struct MoviesSchema: Codable {
    let page: Int
    let results: [MoviesResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MoviesResult: Codable {
    
   
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    
    let posterPath: String?
    let releaseDate, title: String
    
    let voteAverage: Double
    

    enum CodingKeys: String, CodingKey {
        
        
        case genreIDS = "genre_ids"
        case id
        
        case originalTitle = "original_title"
        
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        
    }
}



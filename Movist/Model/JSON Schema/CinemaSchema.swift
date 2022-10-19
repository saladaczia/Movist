//
//  CinemaSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaSchema = try? newJSONDecoder().decode(CinemaSchema.self, from: jsonData)

import Foundation

// MARK: - CinemaSchema
struct CinemaSchema: Codable {
    let page: Int
    let results: [CinemaResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct CinemaResult: Codable {
    
   
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



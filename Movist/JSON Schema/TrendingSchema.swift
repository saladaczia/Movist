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
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: TrendingOriginalLanguage
    let originalTitle, overview, posterPath: String
    let mediaType: TrendingMediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum TrendingMediaType: String, Codable {
    case movie = "movie"
}

enum TrendingOriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
}

//
//  CinemaSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import Foundation

// MARK: - CinemaSchema
struct CinemaSchema: Codable {
    let dates: CinemaDates
    let page: Int
    let results: [CinemaResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct CinemaDates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct CinemaResult: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: CinemaResultOriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum CinemaResultOriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case ru = "ru"
}

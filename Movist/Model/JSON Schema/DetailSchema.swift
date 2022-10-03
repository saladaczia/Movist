//
//  DetailSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import Foundation

// MARK: - DetailSchema
struct DetailSchema {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: NSNull
    let budget: Int
    let genres: [DetailGenre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [DetailProductionCompany]
    let productionCountries: [DetailProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [DetailSpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

// MARK: - Genre
struct DetailGenre {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct DetailProductionCompany {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
}

// MARK: - ProductionCountry
struct DetailProductionCountry {
    let iso3166_1, name: String
}

// MARK: - SpokenLanguage
struct DetailSpokenLanguage {
    let englishName, iso639_1, name: String
}

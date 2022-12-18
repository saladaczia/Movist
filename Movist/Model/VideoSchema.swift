//
//  VideoSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 04/10/2022.
//

import Foundation

// MARK: - Welcome
struct VideoSchema: Codable {
    let id: Int
    let results: [VideoResult]
}

// MARK: - Result
struct VideoResult: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

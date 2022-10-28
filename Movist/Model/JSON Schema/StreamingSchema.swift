//
//  StreamingSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import Foundation

// MARK: - Welcome
struct StreamingSchema: Codable {
    let id: Int
    let results: StreamingResults
}

// MARK: - Results
struct StreamingResults: Codable {
    
    let pl: AE
    

    enum CodingKeys: String, CodingKey {
       
        case pl = "PL"
       
    }
}


// MARK: - Flatrate
struct StreamingFlatrate: Codable {
    
   
    let providerName: String
    

    enum CodingKeys: String, CodingKey {
        
        case providerName = "provider_name"
        
    }
}

// MARK: - AE
struct AE: Codable {
    
    let flatrate: [StreamingFlatrate]?
}

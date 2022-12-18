//
//  MoviesManager.swift
//  Movist
//
//  Created by Maciej Sołoducha on 17/12/2022.
//

import Foundation
import Alamofire

struct MoviesModel {
    let movieModel: [MoviesResult]
}

protocol MoviesManagerDelegate {
    func didUpdateMovie(movie: MoviesModel)
}

struct MoviesManager {
    var delegate: MoviesManagerDelegate?
    
    func performRequest(requestUrl: String) {
        AF.request(requestUrl)
          .validate()
          .responseDecodable(of: MoviesSchema.self) { (response) in
            guard let movies = response.value else { return }
              let moviesList = MoviesModel(movieModel: movies.results)
              self.delegate?.didUpdateMovie(movie: moviesList)
          }
    }
}

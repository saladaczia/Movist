//
//  MovieManager.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//

import Foundation

protocol SearchManagerDelegate {
    func didUpdateMovie(movie: SearchModel)
}

struct SearchManager {
    
    var delegate: SearchManagerDelegate?
    
    func fetchMovie(movieName: String) {
        
        
        
        let urlString =
        "https://api.themoviedb.org/3/search/movie?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&query=\(movieName)&page=1&include_adult=false"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let movie = parseJSON(movieData: safeData) {
                        self.delegate?.didUpdateMovie(movie: movie)
                    }
                }
                
            }
            task.resume()
            
        }
    }
    
    func parseJSON(movieData: Data) -> SearchModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(SearchSchema.self, from: movieData)
            let titleMovie = decodeData.results
            let count = decodeData.results.count
            let movie = SearchModel(movieTitle: titleMovie, numberOfCount: count)
            return movie
        } catch {
            print(error)
            return nil
        }
    }
}

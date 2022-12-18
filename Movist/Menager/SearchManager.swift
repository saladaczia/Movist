//
//  MovieManager.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//

import Foundation
import Alamofire

struct SearchModel {
    let SearchDataModel: [SearchResult]
    let numberOfCount: Int
    
}

protocol SearchManagerDelegate {
    func didUpdateMovie(movie: SearchModel)
}

struct SearchManager {
    
    var delegate: SearchManagerDelegate?
    
    func performRequest(movieName: String) {
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&query=\(movieName)&page=1&include_adult=false")
          .validate()
          .responseDecodable(of: SearchSchema.self) { (response) in
            guard let search = response.value else { return }
              let count = search.results.count
              let searchList = SearchModel(SearchDataModel: search.results, numberOfCount: count)
              self.delegate?.didUpdateMovie(movie: searchList)
          }
    }

}

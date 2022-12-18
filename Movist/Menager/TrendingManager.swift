//
//  TrendingManager.swift
//  Movist
//
//  Created by Maciej Sołoducha on 17/12/2022.
//

import Foundation
import Alamofire

struct TrendingModel {
    let trendingDataModel: [TrendingResult]
}

protocol TrendingManagerDelegate {
    func didUpdateMovie(movie: TrendingModel)
}

struct TrendingManager {
    var delegate: TrendingManagerDelegate?
    
    func runRequest() {
        performRequest()
    }
    
    func performRequest() {
        AF.request("https://api.themoviedb.org/3/trending/movie/week?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&region=PL&page")
          .validate()
          .responseDecodable(of: TrendingSchema.self) { (response) in
            guard let trending = response.value else { return }
              let trendingList = TrendingModel(trendingDataModel: trending.results)
              self.delegate?.didUpdateMovie(movie: trendingList)
          }
    }
}

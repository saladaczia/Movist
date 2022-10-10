//
//  WebController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 04/10/2022.
//

import UIKit
import WebKit

class WebController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var web: WKWebView!
    
    // MARK: - Variables and Constants
    
    var videoId = 0
    
    // MARK: - Function Trailer database
    
    func getDetails() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(videoId)/videos?api_key=dfa4cb178f87b623801a1223f21a555d&language=en-US")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(VideoSchema.self, from: data!)
                DispatchQueue.main.async {
                    
                    
                    let url = URL(string: "https://www.youtube.com/watch?v=\(result.results[0].key)")

                        let request = URLRequest(url: url!)
                    self.web.load(request)
                }
            } catch {
                print("error")
            }
        }.resume()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init movies database
        getDetails()
        
        print(self.videoId)
    }
    

}

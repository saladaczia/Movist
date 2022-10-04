//
//  WebController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 04/10/2022.
//

import UIKit
import WebKit

class WebController: UIViewController {

    @IBOutlet weak var web: WKWebView!
    
    var videoId = 0
    var videoUrlKey = ""
    
    func getDetails() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(videoId)/videos?api_key=dfa4cb178f87b623801a1223f21a555d&language=en-US")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(VideoSchema.self, from: data!)
                DispatchQueue.main.async {
                    self.videoUrlKey = result.results[0].key
                    let url = URL(string: "https://www.youtube.com/watch?v=\(result.results[0].key)")
                        
                        let request = URLRequest(url: url!)
                    self.web.load(request)
                }
            } catch {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        
            
        print(self.videoId)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

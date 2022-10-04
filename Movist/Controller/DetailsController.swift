//
//  DetailsController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class DetailsController: UIViewController{
    
   
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genereLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var StreamigOne: UIImageView!
    @IBOutlet weak var StreamingTwo: UIImageView!
    @IBOutlet weak var StreamingThree: UIImageView!
    
    @IBOutlet weak var testLabel: UILabel!
    
        var movieID = 0
        var movieTitle = ""
    
    func getDetails() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(DetailSchema.self, from: data!)
                DispatchQueue.main.async {
                    self.backdropImage.downloaded(from: "https://image.tmdb.org/t/p/w500/\(result.backdropPath)")
                    self.posterImage.downloaded(from: "https://image.tmdb.org/t/p/w500/\(result.posterPath)")
                    self.titleLabel.text = result.title
                    self.yearLabel.text = String(result.releaseDate.dropLast(6))
                    self.descriptionLabel.text = result.overview
                    self.genereLabel.text = result.genres[0].name
                }
            } catch {
                
            }
        }.resume()
    }
    

    
  

    
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem()
        backButton.title = movieTitle
        backButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        posterImage.layer.borderColor = UIColor(named: "ColorImage")?.cgColor
        posterImage.layer.masksToBounds = true
        posterImage.contentMode = .scaleToFill
        posterImage.layer.borderWidth = 5
        // Do any additional setup after loading the view.
        
        getDetails()
        
    }
    


}

extension UIImageView {
    func downloadedDetails(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedDetails(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

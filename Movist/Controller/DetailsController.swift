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
    @IBOutlet weak var StreamingFour: UIImageView!
    @IBOutlet weak var StreamingFive: UIImageView!
    @IBOutlet weak var StreamingSix: UIImageView!
    
    @IBOutlet weak var conOne: NSLayoutConstraint!
    @IBOutlet weak var conTwo: NSLayoutConstraint!
    @IBOutlet weak var conThree: NSLayoutConstraint!
    @IBOutlet weak var conFour: NSLayoutConstraint!
    @IBOutlet weak var conFive: NSLayoutConstraint!
    @IBOutlet weak var conSix: NSLayoutConstraint!
    
    @IBOutlet weak var spaceTwo: NSLayoutConstraint!
    @IBOutlet weak var spaceThree: NSLayoutConstraint!
    @IBOutlet weak var spaceFour: NSLayoutConstraint!
    @IBOutlet weak var spaceFive: NSLayoutConstraint!
    @IBOutlet weak var spaceSix: NSLayoutConstraint!
    
    
    
    @IBAction func watchTrailer(_ sender: Any) {
        self.performSegue(withIdentifier: "goToWebFromDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebFromDetails" {
            let destinationSVC = segue.destination as! WebController
            destinationSVC.videoId = movieID
        }
    }
    
        var movieID = 0
        var movieTitle = ""
    var providerTable = [String]()
    
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
                    self.yearLabel.text = "\(result.releaseDate.dropLast(6)) | \(result.runtime)min"
                    self.descriptionLabel.text = result.overview
                    self.genereLabel.text = result.genres[0].name
                    
                }
            } catch {
                
            }
        }.resume()
    }
    
    func getProvider() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/watch/providers?api_key=dfa4cb178f87b623801a1223f21a555d")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(StreamingSchema.self, from: data!)
                DispatchQueue.main.async {
                    let myNumber = result.results.pl.flatrate!.count - 1
                    
                    for number in 0...myNumber {
                        self.providerTable.append(result.results.pl.flatrate![number].providerName)
                        
                }
                   
                    if self.providerTable.contains("Netflix") {
                        self.StreamigOne.image = UIImage(named: "Netflix")
                        self.conOne.constant = 48
                    }
                
                    if self.providerTable.contains("Horizon") {
                        self.StreamingTwo.image = UIImage(named: "Horizon")
                        self.conOne.constant = 48
                        if self.providerTable.count > 1 {
                        self.spaceTwo.constant = 8
                        }
                        }
                    
                    if self.providerTable.contains("HBO Max") {
                        self.StreamingThree.image = UIImage(named: "HBO Max")
                        self.conThree.constant = 48
                        if self.providerTable.count > 1 {
                        self.spaceThree.constant = 8
                        }
                    }
                    if self.providerTable.contains("Disney Plus") {
                        self.StreamingFour.image = UIImage(named: "Disney Plus")
                        self.conFour.constant = 48
                        if self.providerTable.count > 1 {
                        self.spaceFour.constant = 8
                        }
                    }
                    if self.providerTable.contains("Apple TV Plus") {
                        self.StreamingFive.image = UIImage(named: "Apple TV Plus")
                        self.conFive.constant = 48
                        if self.providerTable.count > 1 {
                        self.spaceFive.constant = 8
                        }
                    }
                    if self.providerTable.contains("Player") {
                        self.StreamingSix.image = UIImage(named: "Player")
                        self.conSix.constant = 48
                        if self.providerTable.count > 1 {
                        self.spaceSix.constant = 8
                        }
                    }
                    

                    
                    
                    
                    
                    
                }
            } catch {
                print("error")
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
        getProvider()
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

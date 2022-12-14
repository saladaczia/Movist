//
//  DetailsController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit
import NVActivityIndicatorView
import CoreData


class DetailsController: UIViewController{
    
    
    
    // MARK: - Variables and Constants
    
    var movieID: Int64 = 0
    var movieIDTwo = 0
    var movieTitle = ""
    var movieOriginalTitle = ""
    var movieYear = ""
    var movieVote = "0.0"
    var movieGenre = ""
    var providerTable = [String]()
    var movieTrailerUrl = ""
    var posterUrl = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myList = [WatchList]()
    var hiddenAddButton = false
    
    // MARK: - Outlets
    
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
    
    @IBOutlet weak var trailerLabel: UIButton!
    @IBOutlet weak var conTrailer: NSLayoutConstraint!
    @IBOutlet weak var conTrailerW: NSLayoutConstraint!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var streamingLabel: UILabel!
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var LoadingBack: UIView!
    @IBOutlet weak var addWatchListLabel: UIButton!
    
    
    
    // MARK: - Trailer Button Action - Segue
    @IBAction func watchTrailer(_ sender: Any) {
        if movieTrailerUrl != "" {
            self.performSegue(withIdentifier: "goToWebFromDetails", sender: self)
        } else {
            print("error")
        }
        
    }
    
    
    
    
    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebFromDetails" {
            let destinationSVC = segue.destination as! WebController
            destinationSVC.videoUrl = movieTrailerUrl
        }
    }
    
    // MARK: - Get Movie Details
    
    func getDetails() {
        // Api Url
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieIDTwo)?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                let result = try JSONDecoder().decode(DetailSchema.self, from: safeData)
                    
                    // Atributes for CoreData
                    self.movieID = Int64(result.id)
                    self.movieTitle = result.title
                    self.movieOriginalTitle = result.originalTitle
                    self.movieYear = "\(result.releaseDate.dropLast(6))"
                    self.movieGenre = "\(result.genres[0].name)"
                    self.posterUrl = result.posterPath
                    
                    // Update Screen
                    DispatchQueue.main.async {
                        self.backdropImage.downloaded(from: "https://image.tmdb.org/t/p/w500/\(result.backdropPath)")
                        self.posterImage.downloaded(from: "https://image.tmdb.org/t/p/w500/\(result.posterPath)")
                        self.titleLabel.text = result.title
                        self.originalTitleLabel.text = result.originalTitle
                        self.yearLabel.text = "\(result.genres[0].name) | \(result.releaseDate.dropLast(6)) | \(result.runtime)min"
                        self.descriptionLabel.text = result.overview
                        self.starImage.isHidden = false
                        
                        // Optional vote unwrap
                        if result.voteAverage != 0 {
                            self.voteLabel.text = String(format: "%.1f", result.voteAverage)
                            self.movieVote = String(format: "%.1f", result.voteAverage)
                        } else {
                            self.voteLabel.text = "0,0"
                        }
                        
                    // Stop loading screen
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.loadingView.stopAnimating()
                        self.LoadingBack.isHidden = true
                    }
                }
            } catch {
                return
            }
                    }.resume()
    }
    
    // MARK: - Get Trailer
    
    func getTrailer() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieIDTwo)/videos?api_key=dfa4cb178f87b623801a1223f21a555d&language=en-US")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(VideoSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        // Optional unwrap
                        if result.results.isEmpty {
                            self.trailerLabel.isHidden = true
                            self.conTrailer.constant = 0
                            self.conTrailerW.constant = 0
                        } else {
                            self.trailerLabel.isHidden = false
                            self.movieTrailerUrl = result.results[0].key
                        }
                    }
                }
                
            } catch {
                print("error")
            }
        }.resume()
    }
    
    
    // MARK: - Get Provider
    
    func getProvider() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieIDTwo)/watch/providers?api_key=dfa4cb178f87b623801a1223f21a555d")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(StreamingSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        var myNumber = 0
                        if result.results.pl.flatrate?.count != nil {
                            myNumber = result.results.pl.flatrate!.count - 1
                        } else {
                            print("error")
                        }
                        
                        // Add provider to table
                        for number in 0...myNumber {
                            if result.results.pl.flatrate?.count != nil {
                            self.providerTable.append(result.results.pl.flatrate![number].providerName)
                            } else {
                                print("error")
                            }
                    }
                       
                            // Set images provider
                            if self.providerTable.contains("Netflix") {
                                self.StreamigOne.image = UIImage(named: "Netflix")
                                self.conOne.constant = 48
                                self.streamingLabel.isHidden = false
                            }
                        
                            if self.providerTable.contains("Horizon") {
                                self.StreamingTwo.image = UIImage(named: "Horizon")
                                self.conTwo.constant = 48
                                self.streamingLabel.isHidden = false
                                if self.providerTable.count > 1 {
                                self.spaceTwo.constant = 8
                                }
                                }
                            
                            if self.providerTable.contains("HBO Max") {
                                self.StreamingThree.image = UIImage(named: "HBO Max")
                                self.conThree.constant = 48
                                self.streamingLabel.isHidden = false
                                if self.providerTable.count > 1 {
                                self.spaceThree.constant = 8
                                }
                            }
                            if self.providerTable.contains("Disney Plus") {
                                self.StreamingFour.image = UIImage(named: "Disney Plus")
                                self.conFour.constant = 48
                                self.streamingLabel.isHidden = false
                                if self.providerTable.count > 1 {
                                self.spaceFour.constant = 8
                                }
                            }
                            if self.providerTable.contains("Apple TV Plus") {
                                self.StreamingFive.image = UIImage(named: "Apple TV Plus")
                                self.conFive.constant = 48
                                self.streamingLabel.isHidden = false
                                if self.providerTable.count > 1 {
                                self.spaceFive.constant = 8
                                }
                            }
                            if self.providerTable.contains("Player") {
                                self.StreamingSix.image = UIImage(named: "Player")
                                self.conSix.constant = 48
                                self.streamingLabel.isHidden = false
                                if self.providerTable.count > 1 {
                                self.spaceSix.constant = 8
                                }
                            }
                    }
                }
                
            } catch {
                print("error")
            }
        }.resume()
    }
    
    // MARK: - Add Movie To WatchList
    
    @IBAction func addWatchList(_ sender: Any) {
        // Create new item to CoreData
        if addWatchListLabel.isSelected == false {
        let newMovie = WatchList(context: self.context)
        newMovie.originalTitle = movieOriginalTitle
        newMovie.id = Int64(movieID)
        newMovie.title = movieTitle
        newMovie.genre = movieGenre
        newMovie.vote = movieVote
        newMovie.year = movieYear
        newMovie.posterPath = posterUrl
        
            // Update Screen
        
            DispatchQueue.main.async {
                self.myList.append(newMovie)
                let config = UIImage.SymbolConfiguration(weight: .medium)
                self.addWatchListLabel.setImage(UIImage(systemName: "checkmark", withConfiguration: config), for: .normal)
                self.addWatchListLabel.setTitle(" Zapisano", for: .normal)
                self.addWatchListLabel.isSelected = true
                }
        
        do {
            try context.save()
            let notificationNme = NSNotification.Name("NotificationIdf")
             NotificationCenter.default.post(name: notificationNme, object: nil)
        } catch {
            print("Error")
        }
       
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        if hiddenAddButton == true {
            DispatchQueue.main.async {
                let config = UIImage.SymbolConfiguration(weight: .medium)
                self.addWatchListLabel.setImage(UIImage(systemName: "checkmark", withConfiguration: config), for: .normal)
                self.addWatchListLabel.setTitle(" Zapisano", for: .normal)
                self.addWatchListLabel.isSelected = true
                }
        }
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        myList = try! context.fetch(request)
        
        // Init first setting
        LoadingBack.isHidden = false
        loadingView.isHidden = false
        loadingView.type = .ballBeat
        loadingView.startAnimating()
        
        
        // Setings Back button in Navigation Bar
        let backButton = UIBarButtonItem()
        backButton.title = movieTitle
        backButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // init functions
        getDetails()
        getProvider()
        getTrailer()
        
        
    }
}

// MARK: - UIImage Extension (download image from url)

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

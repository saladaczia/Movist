//
//  MoviesController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit
import SimplePopUpMenu

class MoviesController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    // MARK: - Variables and Constants
    
    let myCustomPopUpStyle:PopUpMenuStyle = {
           var result:PopUpMenuStyle = PopUpMenuStyle()
           result.baseColor = UIColor(named: "BarColor")!
           result.textColor = UIColor.white
           result.headerColor = UIColor.black
           result.headerTextColor = UIColor.white
        result.itemSeparatorColor = UIColor.black
        result.selectedBackgroundColor = UIColor(named: "CircleColor")!.withAlphaComponent(0.1)
           return result
       }()
    var yearString = "2022"
    var genreInt = 28
    
    // MARK: - Outlets
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var genresLabel: UIBarButtonItem!
    @IBOutlet weak var yearLabel: UIBarButtonItem!
    
    // MARK: - Year Action
    
    @IBAction func yearButton(_ sender: Any) {
        let popUpMenu:PopUpMenuUIViewControler = PopUpMenuUIViewControler()
           popUpMenu.style = myCustomPopUpStyle
           let items:[PopUpMenuItem] = [
            PopUpMenuItem(title: "2022"),
            PopUpMenuItem(title: "2021"),
            PopUpMenuItem(title: "2020"),
            PopUpMenuItem(title: "2019"),
            PopUpMenuItem(title: "2018"),
            PopUpMenuItem(title: "2017"),
            PopUpMenuItem(title: "2016"),
            PopUpMenuItem(title: "2015"),
            PopUpMenuItem(title: "2014"),
            PopUpMenuItem(title: "2013"),
            PopUpMenuItem(title: "2012"),
            PopUpMenuItem(title: "2011"),
            PopUpMenuItem(title: "2010"),
            PopUpMenuItem(title: "2009"),
            PopUpMenuItem(title: "2008"),
            PopUpMenuItem(title: "2007"),
            PopUpMenuItem(title: "2006"),
            PopUpMenuItem(title: "2005"),
            PopUpMenuItem(title: "2004"),
            PopUpMenuItem(title: "2003"),
            PopUpMenuItem(title: "2002"),
            PopUpMenuItem(title: "2001"),
            PopUpMenuItem(title: "2000")
              ]
        // Showing menu
           popUpMenu.showMenu(menuIdentifier: "menu1", viewController: self, items: items, sourceView: sender,permittedArrowDirections: .any)
        // Set handler
           popUpMenu.setHandler { (selectedMenuIndex) in
               DispatchQueue.main.async {
                   self.yearString = items[selectedMenuIndex].title
                   self.yearLabel.title = items[selectedMenuIndex].title
                   self.getMovies()
               }
            }
    }
    // MARK: - Genere Action
    
    @IBAction func genreButton(_ sender: Any) {
        let popUpMenu:PopUpMenuUIViewControler = PopUpMenuUIViewControler()
           popUpMenu.style = myCustomPopUpStyle
           let items:[PopUpMenuItem] = [
            PopUpMenuItem(title: "Akcja"),
            PopUpMenuItem(title: "Przygodowy"),
            PopUpMenuItem(title: "Animacja"),
            PopUpMenuItem(title: "Komedia"),
            PopUpMenuItem(title: "Kryminał"),
            PopUpMenuItem(title: "Dokumentalny"),
            PopUpMenuItem(title: "Dramat"),
            PopUpMenuItem(title: "Familijny"),
            PopUpMenuItem(title: "Fantasy"),
            PopUpMenuItem(title: "Historyczny"),
            PopUpMenuItem(title: "Horror"),
            PopUpMenuItem(title: "Muzyczny"),
            PopUpMenuItem(title: "Tajemnica"),
            PopUpMenuItem(title: "Romans"),
            PopUpMenuItem(title: "Sci-Fi"),
            PopUpMenuItem(title: "film TV"),
            PopUpMenuItem(title: "Thiller"),
            PopUpMenuItem(title: "Wojenny"),
            PopUpMenuItem(title: "Western")
              ]
        // Showing menu
           popUpMenu.showMenu(menuIdentifier: "menu1", viewController: self, items: items, sourceView: sender,permittedArrowDirections: .any)
        // Set handler
           popUpMenu.setHandler { (selectedMenuIndex) in
               let selectedGenere = items[selectedMenuIndex].title
               self.genresLabel.title = selectedGenere
               
               switch selectedGenere {
               case "Akcja":
                   self.genreInt = 28
                   self.getMovies()
               case "Przygodowy":
                   self.genreInt = 12
                   self.getMovies()
               case "Animacja":
                   self.genreInt = 16
                   self.getMovies()
               case "Komedia":
                   self.genreInt = 35
                   self.getMovies()
               case "Kryminał":
                   self.genreInt = 80
                   self.getMovies()
               case "Dokumentalny":
                   self.genreInt = 99
                   self.getMovies()
               case "Dramat":
                   self.genreInt = 18
                   self.getMovies()
               case "Familijny":
                   self.genreInt = 10751
                   self.getMovies()
               case "Fantasy":
                   self.genreInt = 14
                   self.getMovies()
               case "Historyczny":
                   self.genreInt = 36
                   self.getMovies()
               case "Horror":
                   self.genreInt = 27
                   self.getMovies()
               case "Muzyczny":
                   self.genreInt = 10402
                   self.getMovies()
               case "Tajemnica":
                   self.genreInt = 19648
                   self.getMovies()
               case "Romans":
                   self.genreInt = 10749
                   self.getMovies()
               case "Sci-Fi":
                   self.genreInt = 878
                   self.getMovies()
               case "film TV":
                   self.genreInt = 10770
                   self.getMovies()
               case "Thiller":
                   self.genreInt = 53
                   self.getMovies()
               case "Wojenny":
                   self.genreInt = 10752
                   self.getMovies()
               case "Western":
                   self.genreInt = 37
                   self.getMovies()
               default:
                   self.genreInt = 28
                   self.getMovies()
               }
               
            }
    }
    
    // MARK: - Variables and Constants
    
    var moviesIdNum = 0
    var titleMovie = ""
    
    var moviesList = [MoviesResult]()
    
    
    // MARK: - Function Movies Session and JSON Decode
    
    func getMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&region=PL&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1&year=\(yearString)&with_genres=\(String(self.genreInt))&with_watch_monetization_types=flatrate")
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(MoviesSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        self.moviesList = result.results
                        self.moviesTable.reloadData()
                    }
                }
                
            } catch {
                print("error")
            }
        }.resume()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation title
        navigationItem.title = "Filmy"
        
        // UINib table
        moviesTable.register(UINib(nibName: "TableViewCellMovies", bundle: nil), forCellReuseIdentifier: "cellMovies")
        
        // Init movies database
        getMovies()
        self.moviesTable.reloadData()
    }
    

    // MARK: - Movies Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovies", for: indexPath) as! TableViewCellMovies
        
        cell.pushMovies(data: moviesList[indexPath.row])
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(moviesList[indexPath.row].id)
        self.moviesIdNum = moviesList[indexPath.row].id
        self.titleMovie = moviesList[indexPath.row].title
            self.performSegue(withIdentifier: "goToDetailsFromMovies", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromMovies" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieIDTwo = moviesIdNum
            
        }
    }
}

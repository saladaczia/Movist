//
//  CinemaController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit
import SimplePopUpMenu

class CinemaController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Outlets
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
    
    @IBOutlet weak var cinemaTable: UITableView!
    @IBOutlet weak var genresLabel: UIBarButtonItem!
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
           popUpMenu.showMenu(menuIdentifier: "menu1", viewController: self, items: items, sourceView: sender,permittedArrowDirections: .any)
            
           popUpMenu.setHandler { (selectedMenuIndex) in
               let selectedGenere = items[selectedMenuIndex].title
               self.genresLabel.title = selectedGenere
               
               switch selectedGenere {
               case "Akcja":
                   self.getCinema(genereNumber: 28)
               case "Przygodowy":
                   self.getCinema(genereNumber: 12)
               case "Animacja":
                   self.getCinema(genereNumber: 16)
               case "Komedia":
                   self.getCinema(genereNumber: 35)
               case "Kryminał":
                   self.getCinema(genereNumber: 80)
               case "Dokumentalny":
                   self.getCinema(genereNumber: 99)
               case "Dramat":
                   self.getCinema(genereNumber: 18)
               case "Familijny":
                   self.getCinema(genereNumber: 10751)
               case "Fantasy":
                   self.getCinema(genereNumber: 14)
               case "Historyczny":
                   self.getCinema(genereNumber: 36)
               case "Horror":
                   self.getCinema(genereNumber: 27)
               case "Muzyczny":
                   self.getCinema(genereNumber: 10402)
               case "Tajemnica":
                   self.getCinema(genereNumber: 19648)
               case "Romans":
                   self.getCinema(genereNumber: 10749)
               case "Sci-Fi":
                   self.getCinema(genereNumber: 878)
               case "film TV":
                   self.getCinema(genereNumber: 10770)
               case "Thiller":
                   self.getCinema(genereNumber: 53)
               case "Wojenny":
                   self.getCinema(genereNumber: 10752)
               case "Western":
                   self.getCinema(genereNumber: 37)
               default:
                   self.getCinema(genereNumber: 28)
               }
               
            }
    }
    
    // MARK: - Variables and Constants
    
    var cinemaIdNum = 0
    var titleMovie = ""
    var cinemaList = [CinemaResult]()
    
    
    // MARK: - Function Cinema database
    
    func getCinema(genereNumber: Int) {
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&region=PL&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1&with_genres=\(String(genereNumber))&with_watch_monetization_types=flatrate")
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(CinemaSchema.self, from: data!)
                DispatchQueue.main.async {
                    self.cinemaList = result.results
                    self.cinemaTable.reloadData()
                }
            } catch {
                
            }
        }.resume()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation title
        navigationItem.title = "Filmy"
        
        // UINib table
        cinemaTable.register(UINib(nibName: "TableViewCellCinema", bundle: nil), forCellReuseIdentifier: "cellCinema")
        
        // Init movies database
        getCinema(genereNumber: 28)
        
    }
    

    // MARK: - Cinema Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCinema", for: indexPath) as! TableViewCellCinema
        cell.pushCinema(data: cinemaList[indexPath.row])
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(cinemaList[indexPath.row].id)
        self.cinemaIdNum = cinemaList[indexPath.row].id
        self.titleMovie = cinemaList[indexPath.row].title
            self.performSegue(withIdentifier: "goToDetailsFromCinema", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromCinema" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = cinemaIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
    
}

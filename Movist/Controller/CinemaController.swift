//
//  CinemaController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class CinemaController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Outlets
    
    @IBOutlet weak var cinemaTable: UITableView!
    
    // MARK: - Variables and Constants
    
    var cinemaIdNum = 0
    var titleMovie = ""
    var cinemaList = [CinemaResult]()
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL")
    
    // MARK: - Function Cinema database
    
    func getCinema() {
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
        navigationItem.title = "W kinach"
        
        // UINib table
        cinemaTable.register(UINib(nibName: "TableViewCellCinema", bundle: nil), forCellReuseIdentifier: "cellCinema")
        
        // Init movies database
        getCinema()
        
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

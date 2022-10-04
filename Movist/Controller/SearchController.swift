//
//  SearchController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class SearchController: UIViewController, SearchManagerDelegate, UITableViewDelegate, UITableViewDataSource,  UISearchResultsUpdating {

    var searchIdNum = 0
    var titleMovie = ""
    
    @IBOutlet weak var searchTable: UITableView!
    
    let searchController = UISearchController()
    
    // do edycji
    var cellContent: [Result] = []
    
    func didUpdateMovie(movie: SearchModel) {
        
        DispatchQueue.main.async {
            // Wygenerowana wartość
            self.cellContent = movie.movieTitle
            self.searchTable.reloadData()
            
            
            
        }
    }

    var movieManager = SearchManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Szukaj filmu"
        movieManager.delegate = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        
        movieManager.fetchMovie(movieName: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
       
    }
    
    // TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // identyfikator wiersza w view main
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        // zawartość wiersza
        if cellContent[indexPath.row].releaseDate == nil {
            cell.textLabel?.text = ""
        } else {
            cell.textLabel?.text = "\(cellContent[indexPath.row].title) (\(cellContent[indexPath.row].releaseDate!.dropLast(6)))"
        }
        
        // zwrot wartości wiersza
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(cellContent[indexPath.row].id)
        self.searchIdNum = cellContent[indexPath.row].id
        self.titleMovie = cellContent[indexPath.row].title
        self.performSegue(withIdentifier: "goToDetailsFromSearch", sender: self)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromSearch" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = searchIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
}





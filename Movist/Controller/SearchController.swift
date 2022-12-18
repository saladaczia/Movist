//
//  SearchController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class SearchController: UIViewController, SearchManagerDelegate, UITableViewDelegate, UITableViewDataSource,  UISearchResultsUpdating {

    // MARK: - Outlets
    
    @IBOutlet weak var searchTable: UITableView!
    
    // MARK: - Variables and Constants
    var searchIdNum = 0
    var titleMovie = ""
    let searchController = UISearchController()
    var cellContent = [SearchResult]()
    var searchManager = SearchManager()
    
    // MARK: - Function Search database
    
    func didUpdateMovie(movie: SearchModel) {
        
        DispatchQueue.main.async {
            // Wygenerowana wartość
            self.cellContent = movie.SearchDataModel
            self.searchTable.reloadData()
            
        }
        
    }

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation title
        title = "Szukaj filmu"
        
        // Delegate
        searchManager.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    
    // MARK: - Update Search function
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        searchManager.performRequest(movieName: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
    
    // MARK: - Search Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if cellContent[indexPath.row].releaseDate == nil {
            cell.textLabel?.text = ""
        } else {
            cell.textLabel?.text = "\(cellContent[indexPath.row].title) (\(cellContent[indexPath.row].releaseDate!.dropLast(6)))"
        }
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(cellContent[indexPath.row].id)
        self.searchIdNum = cellContent[indexPath.row].id
        self.titleMovie = cellContent[indexPath.row].title
        self.performSegue(withIdentifier: "goToDetailsFromSearch", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromSearch" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieIDTwo = searchIdNum
            
        }
    }
    
    
}





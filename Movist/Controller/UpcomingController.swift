//
//  UpcomingController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class UpcomingController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var upcomingTable: UITableView!
    
    // MARK: - Variables and Constants
    
    var upcomingIdNum = 0
    var titleMovie = ""
    var upcomingList = [UpcomingResult]()
    let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL")
    
    // MARK: - Function Upcoming database
    
    func getUpcoming(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(UpcomingSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        self.upcomingList += result.results
                        self.upcomingTable.reloadData()
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
        navigationItem.title = "Top filmy"
        
        
        
        // Init movies database
        
            
            getUpcoming(urlString: "https://api.themoviedb.org/3/movie/top_rated?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL&page")
            
        
        
        // UINib table
        upcomingTable.register(UINib(nibName: "TableViewCellUpcoming", bundle: nil), forCellReuseIdentifier: "cellUpcoming")
        self.upcomingTable.reloadData()
    }
    
    // MARK: - Upcoming Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUpcoming", for: indexPath) as! TableViewCellUpcoming
        
        cell.pushUpcoming(data: upcomingList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(upcomingList[indexPath.row].id)
        self.upcomingIdNum = upcomingList[indexPath.row].id
        self.titleMovie = upcomingList[indexPath.row].title!
        
        self.performSegue(withIdentifier: "goToDetailsFromUpcoming", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromUpcoming" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = upcomingIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
    
}

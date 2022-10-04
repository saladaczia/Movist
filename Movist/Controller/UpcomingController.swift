//
//  UpcomingController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class UpcomingController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var upcomingIdNum = 0
    var titleMovie = ""
    
    @IBOutlet weak var upcomingTable: UITableView!
    
    var upcomingList = [UpcomingResult]()
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Premiery"
        
        upcomingTable.register(UINib(nibName: "TableViewCellUpcoming", bundle: nil), forCellReuseIdentifier: "cellUpcoming")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(UpcomingSchema.self, from: data!)
                DispatchQueue.main.async {
                    self.upcomingList = result.results
                    self.upcomingTable.reloadData()
                }
            } catch {
                
            }
        }.resume()
    }
    
    // Trending Table
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
        self.titleMovie = upcomingList[indexPath.row].title
        
        self.performSegue(withIdentifier: "goToDetailsFromUpcoming", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromUpcoming" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = upcomingIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
}

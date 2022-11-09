//
//  TopController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class TopController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var TopTable: UITableView!
    
    // MARK: - Variables and Constants
    
    var TopIdNum = 0
    var titleMovie = ""
    var TopList = [TopResult]()
    let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL")
    
    // MARK: - Function Top database
    
    func getTop(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(TopSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        self.TopList += result.results
                        self.TopTable.reloadData()
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
        
            
            getTop(urlString: "https://api.themoviedb.org/3/movie/top_rated?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&page=1&region=PL&page")
            
        
        
        // UINib table
        TopTable.register(UINib(nibName: "TableViewCellTop", bundle: nil), forCellReuseIdentifier: "cellTop")
        self.TopTable.reloadData()
    }
    
    // MARK: - Top Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTop", for: indexPath) as! TableViewCellTop
        
        cell.pushUpcoming(data: TopList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(TopList[indexPath.row].id)
        self.TopIdNum = TopList[indexPath.row].id
        self.titleMovie = TopList[indexPath.row].title!
        
        self.performSegue(withIdentifier: "goToDetailsFromTop", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromTop" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = TopIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
    
}

//
//  TrendingController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit



class TrendingController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var trendingTable: UITableView!
    
    // MARK: - Variables and Constants
    var pageNumber = 1
    var tradingIdNum = 0
    var titleMovie = ""
    var trendingList = [TrendingResult]()
    
    // MARK: - Function Trending database
    
    func getTrending(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data,response,error) in
        
            do {
                if let safeData = data {
                    let result = try JSONDecoder().decode(TrendingSchema.self, from: safeData)
                    DispatchQueue.main.async {
                        self.trendingList += result.results
                        self.trendingTable.reloadData()
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
        navigationItem.title = "Popularne"
        
        // UINib table
        trendingTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Init movies database
        for i in 0...9 {
            pageNumber += i
            getTrending(urlString: "https://api.themoviedb.org/3/trending/movie/week?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL&region=PL&page=\(pageNumber)")
        }
        

    }
    
    
    // MARK: - Trending Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.pushTrending(data: trendingList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(trendingList[indexPath.row].id)
        self.tradingIdNum = trendingList[indexPath.row].id
        self.titleMovie = trendingList[indexPath.row].title
        self.performSegue(withIdentifier: "goToDetailsFromTrending", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromTrending" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieID = tradingIdNum
            destinationSVC.movieTitle = titleMovie
        }
    }
    
    
}

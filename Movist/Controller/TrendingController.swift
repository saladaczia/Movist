//
//  TrendingController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit



class TrendingController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, TrendingManagerDelegate {
   
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var trendingTable: UITableView!
    
    // MARK: - Variables and Constants
    
    var tradingIdNum = 0
    var titleMovie = ""
    var trendingList = [TrendingResult]()
    var trendingManager = TrendingManager()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation title
        navigationItem.title = "Popularne"
        
        trendingManager.delegate = self
        trendingManager.runRequest()
        
            

        // UINib table
        trendingTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.trendingTable.reloadData()
    }
    
    func didUpdateMovie(movie: TrendingModel) {
        self.trendingList += movie.trendingDataModel
        self.trendingTable.reloadData()
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
            destinationSVC.movieIDTwo = tradingIdNum
            
        }
    }
    
    
}

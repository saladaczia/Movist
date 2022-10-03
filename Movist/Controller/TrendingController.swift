//
//  TrendingController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit

class TrendingController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var trendingTable: UITableView!
    
    var trendingList = [TrendingResult]()
    let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=dfa4cb178f87b623801a1223f21a555d&language=pl-PL")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popularne"
        
        trendingTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        URLSession.shared.dataTask(with: url!) {
            (data,req,error) in
            do {
                let result = try JSONDecoder().decode(TrendingSchema.self, from: data!)
                DispatchQueue.main.async {
                    self.trendingList = result.results
                    self.trendingTable.reloadData()
                }
            } catch {
                
            }
        }.resume()
        
    }
    
    
    // Trending Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.pushTrending(data: trendingList[indexPath.row])
        return cell
    }

}

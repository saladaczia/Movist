//
//  MyListController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 29/09/2022.
//

import UIKit
import CoreData

class MyListController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var MyListTable: UITableView!
    
    // MARK: - Variables and Constants
    
    var MyListIdNum:Int64 = 0
    var titleMovie = ""
    var myList = [WatchList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - ReloadTableView after added movie
    
    @objc func reloadTableview() {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        myList = try! context.fetch(request)
        self.MyListTable.reloadData()
    }
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation title
        navigationItem.title = "Moja Lista"
        
        // Core data request
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        myList = try! context.fetch(request)
            
        // UINib table
        MyListTable.register(UINib(nibName: "TableViewCellMyList", bundle: nil), forCellReuseIdentifier: "cellMyList")
        self.MyListTable.reloadData()
        
        // Init selector to reload table after added movie to list
        let notificationName = NSNotification.Name("NotificationIdf")
           NotificationCenter.default.addObserver(self, selector: #selector(MyListController.reloadTableview), name: notificationName, object: nil)
    }
   
    
    // MARK: - MyList Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMyList", for: indexPath) as! TableViewCellMyList
        
        cell.pushUpcoming(data: myList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.MyListIdNum = myList[indexPath.row].id
        self.titleMovie = myList[indexPath.row].title!
        self.performSegue(withIdentifier: "goToDetailsFromMyList", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Delete table functions
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            context.delete(myList[indexPath.row])
            myList.remove(at: indexPath.row)
            do {
                try context.save()
            } catch {
                print("Error")
            }
            MyListTable.reloadData()
        }
    }
    
    // MARK: - Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromMyList" {
            let destinationSVC = segue.destination as! DetailsController
            destinationSVC.movieIDTwo = Int(MyListIdNum)
        }
    } 
}

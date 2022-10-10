//
//  WebController.swift
//  Movist
//
//  Created by Maciej Sołoducha on 04/10/2022.
//

import UIKit
import WebKit

class WebController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var web: WKWebView!
    
    // MARK: - Variables and Constants
    
    
    var videoUrl = ""
    
    // MARK: - Function Trailer database
    
    func getDetails() {
        
                DispatchQueue.main.async {
                    
                    
                    let url = URL(string: "https://www.youtube.com/watch?v=\(self.videoUrl)")

                        let request = URLRequest(url: url!)
                    self.web.load(request)
                }
            
        }
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init movies database
        getDetails()
        
        
    }
    

}

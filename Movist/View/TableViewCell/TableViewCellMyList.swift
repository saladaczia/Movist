//
//  TableViewCellUpcoming.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//

import UIKit
import CoreData

class TableViewCellMyList: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabelCell: UILabel!
    @IBOutlet weak var yearLabelCell: UILabel!
    @IBOutlet weak var originalTitleLabelCell: UILabel!
    @IBOutlet weak var voteLabelCell: UILabel!
    @IBOutlet weak var posterImageCell: UIImageView!
    @IBOutlet weak var genreLabelCell: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function push Upcoming database
    func pushUpcoming(data: WatchList) {
        
        genreLabelCell.text = data.genre
        
        
        
        titleLabelCell.text = data.title
        originalTitleLabelCell.text = data.originalTitle
        yearLabelCell.text = data.year
        
        voteLabelCell.text = data.vote
        genreLabelCell.text = data.genre
        DispatchQueue.main.async {
            
                self.posterImageCell.downloadedMyList(from: "https://image.tmdb.org/t/p/w500/\(data.posterPath!)")
            
        }
        
    }
    
}

// MARK: - UIImage Extension (download image from url)
extension UIImageView {
    func downloadedMyList(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedMyList(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
    


//
//  TableViewCellUpcoming.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//

import UIKit

class TableViewCellUpcoming: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabelCellUpcoming: UILabel!
    @IBOutlet weak var yearLabelCellUpcoming: UILabel!
    @IBOutlet weak var descriptionLabelCellUpcoming: UILabel!
    @IBOutlet weak var posterImageCellUpcoming: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function push Upcoming database
    func pushUpcoming(data: UpcomingResult) {
        titleLabelCellUpcoming.text = data.title
        yearLabelCellUpcoming.text = data.releaseDate
        if data.overview == "" {
            descriptionLabelCellUpcoming.text = "Brak opisu"
        } else {
            descriptionLabelCellUpcoming.text = data.overview
        }
        if data.posterPath == nil {
            print("error")
        } else {
            posterImageCellUpcoming.downloaded(from: "https://image.tmdb.org/t/p/w342/\(data.posterPath!)")
        }
        
        
    }
    
}

// MARK: - UIImage Extension (download image from url)
extension UIImageView {
    func downloadedUpcoming(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadedUpcoming(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
    


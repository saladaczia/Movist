//
//  TableViewCellCinema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 03/10/2022.
//

import UIKit

class TableViewCellCinema: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabelCellCinema: UILabel!
    @IBOutlet weak var yearLabelCellCinema: UILabel!
    @IBOutlet weak var descriptionLabelCellCinema: UILabel!
    @IBOutlet weak var posterImageCellCinema: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function push Cinema database
    
    func pushCinema(data: CinemaResult) {
        titleLabelCellCinema.text = data.title
        yearLabelCellCinema.text = data.releaseDate
        if data.overview == "" {
            descriptionLabelCellCinema.text = "Brak opisu"
        } else {
            descriptionLabelCellCinema.text = data.overview
        }
        if data.posterPath == nil {
            print("error")
        } else {
            posterImageCellCinema.downloaded(from: "https://image.tmdb.org/t/p/w342/\(data.posterPath!)")
        }
        
    }
    
}

// MARK: - UIImage Extension (download image from url)
extension UIImageView {
    func downloadedCinema(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadedCinema(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

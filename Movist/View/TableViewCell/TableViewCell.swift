//
//  TableViewCell.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabelCell: UILabel!
    @IBOutlet weak var yearLabelCell: UILabel!
    @IBOutlet weak var descriptionLabelCell: UILabel!
    @IBOutlet weak var posterImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pushTrending(data: TrendingResult) {
        titleLabelCell.text = data.title
        yearLabelCell.text = "\(data.releaseDate.dropLast(6))"
        descriptionLabelCell.text = data.overview
        posterImageCell.downloaded(from: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")
        
        
    }
    
}

// Extension Image for Posters
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

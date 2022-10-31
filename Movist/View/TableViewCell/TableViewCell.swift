//
//  TableViewCell.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
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
    
    // MARK: - Function push Trending database
    
    func pushTrending(data: TrendingResult) {
        var genreString = ""
        
        switch data.genreIDS[0] {
        case 28:
            genreString = "Akcja"
        case 12:
            genreString = "Przygodowy"
        case 16:
            genreString = "Animacja"
        case 35:
            genreString = "Komedia"
        case 80:
            genreString = "Kryminał"
        case 99:
            genreString = "Dokumentalny"
        case 18:
            genreString = "Dramat"
        case 10751:
            genreString = "Familijny"
        case 14:
            genreString = "Fantasy"
        case 36:
            genreString = "Historyczny"
        case 27:
            genreString = "Horror"
        case 10402:
            genreString = "Muzyczny"
        case 19648:
            genreString = "Tajemnica"
        case 10749:
            genreString = "Romans"
        case 878:
            genreString = "Sci-Fi"
        case 10770:
            genreString = "film TV"
        case 53:
            genreString = "Thiller"
        case 10752:
            genreString = "Wojenny"
        case 37:
            genreString = "Western"
        default:
            genreString = ""
        }
        
        titleLabelCell.text = data.title
        originalTitleLabelCell.text = data.originalTitle
        yearLabelCell.text = "\(data.releaseDate.dropLast(6))"
        voteLabelCell.text = String(format: "%.1f", data.voteAverage)
        genreLabelCell.text = genreString
       
        posterImageCell.downloaded(from: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")
        
        
    }
    
}

// MARK: - UIImage Extension (download image from url)
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

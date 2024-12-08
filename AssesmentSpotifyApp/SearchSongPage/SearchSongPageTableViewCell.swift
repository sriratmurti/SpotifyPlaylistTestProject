//
//  SearchSongPageTableViewCell.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit

class SearchSongPageTableViewCell: UITableViewCell {
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(from url: URL) {
            // Mengambil data gambar dari URL
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Memastikan tidak ada error dan data valid
                if let data = data, let image = UIImage(data: data) {
                    // Memperbarui UI di thread utama
                    DispatchQueue.main.async {
                        self.songImageView.image = image
                    }
                }
            }.resume()
        }
    
}

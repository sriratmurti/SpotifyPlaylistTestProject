//
//  PlaylistCollectionViewCell.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var playListTitleLabel: UILabel!
    @IBOutlet weak var playlistDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.setCustomSpacing(12, after:playlistImageView)
        stackView.setCustomSpacing(2, after: playListTitleLabel)
        playlistImageView.image = UIImage(named: "album_cover")
    }

}

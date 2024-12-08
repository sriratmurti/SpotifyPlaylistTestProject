//
//  PlaylistTableViewCell.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    @IBOutlet weak var playListNameLabel: UILabel!
    @IBOutlet weak var songCountLabel: UILabel!
    
    var playListName = ""
    var songCount = 0
    var cellTapped : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playListNameLabel.text = playListName
        songCountLabel.text = String(songCount)
        print("tableViewCell \(playListName) \(songCount)")
    }
    
}

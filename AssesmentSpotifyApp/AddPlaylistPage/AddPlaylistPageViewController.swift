//
//  AddPlaylistPageViewController.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 06/12/24.
//

import UIKit

class AddPlaylistPageViewController: UIViewController {
    
    @IBOutlet weak var addSongView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addSongStackView: UIStackView!
    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var addPlaylistTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureCreate: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCreatePlaylist(_:)))
        addSongView.addGestureRecognizer(tapGestureCreate)

        let tapGestureCancel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToCancel(_:)))
        bgView.addGestureRecognizer(tapGestureCancel)
    }

    @objc func tapCreatePlaylist(_ gesture: UITapGestureRecognizer) {
        print("create playlist tapped")
        addPlaylistTapped?()
    }
    
    @objc func tapToCancel(_ gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }

}


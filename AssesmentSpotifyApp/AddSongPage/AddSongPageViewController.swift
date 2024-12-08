//
//  AddSongPageViewController.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit
import CoreData

class AddSongPageViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var songCountLabel: UILabel!
    @IBOutlet weak var libraryTitleLabel: UILabel!
    @IBOutlet weak var songTableView: UITableView!
    
    var titleLabel = ""
    var songTitle: [String] = []
    var artistName: [String] = []
    var imageURL: [String] = []
    var songCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        songTitle = []
        artistName = []
        imageURL = []
        fetchplaylistSong(playlistName: titleLabel)
        updatePlaylist(playlistName: titleLabel, songCount: songTitle.count)
        songCountLabel.text = String(songTitle.count) + " songs"
    }
    
    func updatePlaylist(playlistName: String, songCount: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LibraryData> = LibraryData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playlistName == %@", playlistName)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if let playlist = result.first {
                playlist.count = Int64(songCount)
                
                try context.save()
            }else {
                print("failed update")
            }
        } catch {
            return
        }
    }
    
    func fetchplaylistSong(playlistName: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LibraryData> = LibraryData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playlistName == %@", playlistName)
        
        do {
            let playlist = try context.fetch(fetchRequest)
            if let playlist = playlist.first {
                print("nama playlist = \(playlist)")
                for song in playlist.songs as? Set<PlaylistData> ?? [] {
                    songTitle.append(song.songTitle ?? "")
                    artistName.append(song.artisName ?? "")
                    imageURL.append(song.imageURL ?? "")
                    
                    print("Song: \(song.songTitle), \(song.artisName) ")
                    songTableView.reloadData()
                }
            } else {
                print("playlist not found")
            }
        } catch {
            print("request failed")
        }
    }

    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        backButton.setImage(UIImage(named: "back_icon"), for: .normal)
        let nib = UINib(nibName: String(describing: SongsTableViewCell.self), bundle: nil)
        songTableView.register(nib, forCellReuseIdentifier: String(describing: SongsTableViewCell.self))
        songTableView.delegate = self
        songTableView.dataSource = self
        libraryTitleLabel.text = titleLabel
        
        songCountLabel.text = String(songCount) + " songs"
    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSongBtnAction(_ sender: Any) {
        let vc = SearchSongPageViewController()
        vc.playlistName = libraryTitleLabel.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AddSongPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SongsTableViewCell.self), for: indexPath) as! SongsTableViewCell
        if let url = URL(string: imageURL[indexPath.row]) {
            cell.loadImage(from: url)
        }
        cell.titleSongLabel.text = songTitle[indexPath.row]
        cell.descSongLabel.text = artistName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

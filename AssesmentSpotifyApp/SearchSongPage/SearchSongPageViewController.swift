//
//  SearchSongPageViewController.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit
import CoreData

class SearchSongPageViewController: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var recentSearchLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var songs: [Songs] = [Songs]()
    var searchKeyword = ""
    var playlistName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func setupView() {
        let nib = UINib(nibName: String(describing: SearchSongPageTableViewCell.self), bundle: nil)
        searchResultTableView.register(nib, forCellReuseIdentifier: String(describing: SearchSongPageTableViewCell.self))
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    
    func getAPI(keyword: String) {
        let provider = NetworkManager<ConstantAPI>(isVerbose: true)
        provider.api().request(.songList(keyword: keyword)) { result in
            switch result {
            case .success(let response):
                print("songList \(response)")
                guard let data = ResponseParser.shared.parse(to: SongResults.self, from: response)
                else {
                    print("error parsing data")
                    return
                }
                print("data: \(data)")
                self.songs = data.results
                self.searchResultTableView.reloadData()
                
            case .failure(let err):
                print("error getting pokemon list \(err.localizedDescription)")
            }
        }
    }
    
    func pushSongCoreData(playlistName: String, artistName: String, trackName: String, imageURL: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LibraryData> = LibraryData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playlistName == %@", playlistName)
        
        do {
            let playlist = try context.fetch(fetchRequest)
            if let playlist = playlist.first {
                let song = PlaylistData(context: context)
                song.artisName = artistName
                song.songTitle = trackName
                song.imageURL = imageURL
                song.playlist = playlist
                
                try context.save()
                print("song added to playlist")
            } else {
                print("playlist not found")
            }

        } catch {
            print("failed to fetch or save data")
        }
    }

}

extension SearchSongPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: String(describing: SearchSongPageTableViewCell.self), for: indexPath) as! SearchSongPageTableViewCell
        cell.songTitleLabel.text = songs[indexPath.row].trackName
        cell.artistNameLabel.text = songs[indexPath.row].artistName
        if let imageUrl = URL(string: songs[indexPath.row].artworkUrl100) {
            cell.loadImage(from: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushSongCoreData(playlistName: playlistName, artistName: songs[indexPath.row].artistName, trackName: songs[indexPath.row].trackName, imageURL: songs[indexPath.row].artworkUrl100)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchSongPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getAPI(keyword: searchKeyword)
        searchBarView.endEditing(true)
    }
}

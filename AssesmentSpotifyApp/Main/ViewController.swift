//
//  ViewController.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 06/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var yourLibraryLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var listGridButton: UIButton!
    @IBOutlet weak var playlistLabelView: UIView!
    @IBOutlet weak var playlistButton: UIButton!
    
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var libraryCollectionView: UICollectionView!
    @IBOutlet weak var tabBarView: UITabBar!
    @IBOutlet weak var searchTabItem: UITabBarItem!
    @IBOutlet weak var libraryTabItem: UITabBarItem!
    
    var songs: [Song] = [Song]()
    var addedLibraryName = ""
    var playlist: [String] = [String]()
    var song: [Int] = [Int]()
    var playlist1 = ["a", "b", "c", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playlist = []
        song = []
        fetchCoreData()
    }
    
    func setupView() {
        tabBarView.selectedItem = libraryTabItem
        searchTabItem.image = UIImage(named: "search_icon")
        libraryTabItem.image = UIImage(named: "library_icon")
        playlistButton.layer.borderColor = UIColor.lightGray.cgColor
        playlistButton.layer.borderWidth = 1
        playlistButton.layer.cornerRadius = 12
        
        let tableNib = UINib(nibName: String(describing: PlaylistTableViewCell.self), bundle: nil)
        let collectionNib = UINib(nibName: String(describing: PlaylistCollectionViewCell.self), bundle: nil)
        libraryTableView.register(tableNib, forCellReuseIdentifier: String(describing: PlaylistTableViewCell.self))
        libraryCollectionView.register(collectionNib, forCellWithReuseIdentifier: String(describing: PlaylistCollectionViewCell.self))
        
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
        libraryCollectionView.delegate = self
        libraryCollectionView.dataSource = self
    }
    
    
    func pushCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LibraryData", in: context)
        let newPlaylist = NSManagedObject(entity: entity!, insertInto: context)
        
        newPlaylist.setValue("Playlist 1", forKey: "playlistName")
        newPlaylist.setValue(1, forKey: "count")
        
        do {
            try context.save()
        } catch {
            print("failed storing data")
        }
    }
    
    func fetchCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LibraryData")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print("nama playlist \(data.value(forKey: "playlistName") as! String)")
                print(data.value(forKey: "count") as! Int64)
                var playlistName = data.value(forKey: "playlistName") as! String
                var songCount = data.value(forKey: "count") as! Int64
                playlist.append(playlistName)
                song.append(Int(songCount))
                print("playlist dan count \(playlist) & \(song)")
                libraryTableView.reloadData()
                libraryCollectionView.reloadData()
            }
        } catch {
            print("request failed")
        }
    }
    

    @IBAction func listGridBtnAction(_ sender: UIButton) {
        listGridButton.isSelected = !listGridButton.isSelected
        
        if listGridButton.isSelected {
            listGridButton.setImage(UIImage(named: "list_icon"), for: .normal)
            libraryCollectionView.isHidden = false
            libraryTableView.isHidden = true
        } else {
            listGridButton.setImage(UIImage(named: "grid_icon"), for: .normal)
            libraryCollectionView.isHidden = true
            libraryTableView.isHidden = false
            
        }
    }
    
    @IBAction func addBtnAction(_ sender: UIButton) {
        let vc = AddPlaylistPageViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.addPlaylistTapped = {
            vc.dismiss(animated: false)
            let vc2 = PlaylistNameViewController()
            vc2.modalPresentationStyle = .popover
            vc2.addPlaylistName = {
                self.addedLibraryName = vc2.libraryName
                print("passed library name \(self.addedLibraryName)")
                vc2.dismiss(animated: true)
                
                let vc3 = AddSongPageViewController(nibName: "AddSongPageViewController", bundle: nil)
                vc3.titleLabel = self.addedLibraryName
                self.navigationController?.pushViewController(vc3, animated: true)
                print("self \(self)")
//                self.present(vc3, animated: false)
            }
            self.present(vc2, animated: true)
        }
        self.present(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = libraryTableView.dequeueReusableCell(withIdentifier: String(describing: PlaylistTableViewCell.self), for: indexPath) as! PlaylistTableViewCell
        cell.playListNameLabel.text = playlist[indexPath.row]
        cell.songCountLabel.text = String(song[indexPath.row]) + " songs"
//        cell.isSelected = false
        print(playlist)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddSongPageViewController()
        vc.titleLabel = playlist[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = libraryCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaylistCollectionViewCell.self), for: indexPath) as! PlaylistCollectionViewCell
        
        cell.playListTitleLabel.text = playlist[indexPath.row]
        cell.playlistDescLabel.text = "Playlist " + String(song[indexPath.row]) + " songs"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddSongPageViewController()
        vc.titleLabel = playlist[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 226)
    }
}

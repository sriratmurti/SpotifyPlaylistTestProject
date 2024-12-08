//
//  PlaylistNameViewController.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import UIKit
import CoreData

class PlaylistNameViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    var libraryName = ""
    var addPlaylistName: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        confirmButton.layer.cornerRadius = 12
    }
    
    func pushLobraryNameCoreData(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LibraryData", in: context)
        let newPlaylist = NSManagedObject(entity: entity!, insertInto: context)
        
        newPlaylist.setValue(name, forKey: "playlistName")
        
        do {
            try context.save()
        } catch {
            print("failed storing data")
        }
    }

    @IBAction func confirmBtnAction(_ sender: Any) {
        if nameTextField.text != "" {
            libraryName = nameTextField.text ?? ""
            addPlaylistName?()
            pushLobraryNameCoreData(name: libraryName)
        } else {
            print("nama kosong")
        }
        print("tapped")
        print(libraryName)
        textFieldDidEndEditing(nameTextField)
        
        let vc = AddSongPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension PlaylistNameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
}

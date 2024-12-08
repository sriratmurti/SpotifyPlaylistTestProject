//
//  SearchEntity.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import Foundation
struct SongResults: Codable {
    let resultCount: Int
    let results: [Songs]
}

struct Songs: Codable {
    let kind: String
    let artistId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    
    enum CodingKeys: String, CodingKey {
        case kind, artistId, trackId, artistName, trackName, artworkUrl30, artworkUrl60, artworkUrl100
    }
    
    init(kind: String, artistId: Int, trackId: Int, artistName: String, trackName: String, artworkUrl30: String, artworkUrl60: String, artworkUrl100: String) {
        self.kind = kind
        self.artistId = artistId
        self.trackId = trackId
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.artistId = try container.decode(Int.self, forKey: .artistId)
        self.trackId = try container.decode(Int.self, forKey: .trackId)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.artworkUrl30 = try container.decode(String.self, forKey: .artworkUrl30)
        self.artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
    }
}

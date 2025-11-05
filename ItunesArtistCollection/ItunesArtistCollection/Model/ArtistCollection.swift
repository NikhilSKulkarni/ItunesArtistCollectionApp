//
//  ArtistCollection.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//

import Foundation

struct APIResponse: Codable {
    let results: [ArtistCollection]
}

struct ArtistCollection: Codable, Hashable {
    let trackId: Int
    let trackName: String
    let collectionName: String
    let artworkUrl100: String
    
    enum codingKeys: String, CodingKey {
        case trackId, trackName, collectionName
        case albumThumbnailUrl = "artworkUrl100"
    }
}

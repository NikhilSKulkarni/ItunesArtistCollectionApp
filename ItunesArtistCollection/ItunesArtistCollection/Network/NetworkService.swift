//
//  NetworkService.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//

import Foundation

protocol ArtistCollectionServiceProtocol {
    func fetchArtistCollection() async throws -> [ArtistCollection]
}

class NetworkService: ArtistCollectionServiceProtocol {
    func fetchArtistCollection() async throws -> [ArtistCollection] {
        guard let requestUrl = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: requestUrl)
        
        guard let stausCode = (response as? HTTPURLResponse)?.statusCode, stausCode == 200 else {
            throw NetworkError.requestFailed
        }
         
        do{
            let artistResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            return artistResponse.results
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

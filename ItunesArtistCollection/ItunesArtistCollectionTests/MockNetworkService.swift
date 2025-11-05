//
//  MockNetworkService.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 06/11/25.
//
import Foundation
@testable import ItunesArtistCollection

class MockNetworkService: ArtistCollectionServiceProtocol {
    var shouldThrowError: NetworkError?
    var mockFileName: String?
    
    func fetchArtistCollection() async throws -> [ArtistCollection] {
        if let error = shouldThrowError {
            throw error
        }
        
        guard let fileName = mockFileName,
              let url = Bundle(for: MockNetworkService.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NetworkError.decodingFailed
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([ArtistCollection].self, from: data)
    }
}

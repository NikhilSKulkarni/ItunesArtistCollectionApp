//
//  ArtistCollectionListViewModel.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//

import Foundation

protocol ArtistCollectionViewModelProtocol {
    func loadArtistCollections() async
}

@MainActor
class ArtistCollectionListViewModel: ObservableObject, ArtistCollectionViewModelProtocol {
    
    @Published var artistCollections: [ArtistCollection] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var networkService: ArtistCollectionServiceProtocol
    
    init(networkService: ArtistCollectionServiceProtocol) {
        self.networkService = networkService
    }
    
    // Fetch the artist's itunes collection from API
    func loadArtistCollections() async {
        isLoading = true
        errorMessage = nil

        do {
            artistCollections = try await networkService.fetchArtistCollection()
            isLoading = false
        } catch let error as NetworkError {
            switch error {
            case .invalidUrl:
                errorMessage = "Invalid URL"
            case .requestFailed:
                errorMessage = "Request Failed"
            case .decodingFailed:
                errorMessage = "Json decoding failed"
            }
            isLoading = false
        } catch {
            errorMessage = "UnKnownError"
            isLoading = false
        }
    }
    
    
}

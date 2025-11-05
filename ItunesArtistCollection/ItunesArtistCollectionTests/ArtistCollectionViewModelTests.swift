//
//  ArtistCollectionViewModelTests.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 06/11/25.
//
import Foundation
import XCTest
@testable import ItunesArtistCollection

@MainActor
final class ArtistCollectionListViewModelTests: XCTestCase {
    
    var viewModel: ArtistCollectionListViewModel!
    var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = ArtistCollectionListViewModel(networkService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadArtistCollections_Success() async {
        mockService.mockFileName = "ArtistCollectionSuccess"
        
        await viewModel.loadArtistCollections()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.artistCollections.count, 2)
        XCTAssertEqual(viewModel.artistCollections.first?.trackName, "The Fate of Ophelia")
    }
    
    func testLoadArtistCollections_InvalidUrlError() async {
        mockService.shouldThrowError = .invalidUrl
        
        await viewModel.loadArtistCollections()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Invalid URL")
        XCTAssertTrue(viewModel.artistCollections.isEmpty)
    }
    
    func testLoadArtistCollections_RequestFailedError() async {
        mockService.shouldThrowError = .requestFailed
        
        await viewModel.loadArtistCollections()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Request Failed")
    }
    
    func testLoadArtistCollections_DecodingFailedError() async {
        mockService.shouldThrowError = .decodingFailed
        
        await viewModel.loadArtistCollections()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Json decoding failed")
    }
    
    func testLoadArtistCollections_UnknownError() async {
        class UnknownErrorService: ArtistCollectionServiceProtocol {
            func fetchArtistCollection() async throws -> [ArtistCollection] {
                throw URLError(.badServerResponse)
            }
        }
        
        let unknownService = UnknownErrorService()
        viewModel = ArtistCollectionListViewModel(networkService: unknownService)
        
        await viewModel.loadArtistCollections()
        
        XCTAssertEqual(viewModel.errorMessage, "UnKnownError")
    }
}

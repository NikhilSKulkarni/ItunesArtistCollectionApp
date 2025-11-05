//
//  ArtistCollectionListView.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//

import SwiftUI

struct ArtistCollectionListView: View {
    @StateObject private var viewModel = ArtistCollectionListViewModel(networkService: NetworkService())
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    VStack(alignment: .leading) {
                        List(viewModel.artistCollections, id: \.trackId) { track in
                            NavigationLink(value: track ) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(track.trackName)
                                            .foregroundColor(.primary)
                                            .font(.headline)
                                        Text(track.collectionName)
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Itunes collection ")
            .navigationDestination(for: ArtistCollection.self) { artistCollection in
                ArtistCollectionDetailView()
            }
            .task {
                await viewModel.loadArtistCollections()
            }
        }
    }
}

#Preview {
    ArtistCollectionListView()
}

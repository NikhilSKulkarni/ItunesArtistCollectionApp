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
                                    AsyncImage(url: URL(string: track.artworkUrl100)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipShape(AnyShape(Circle()))
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .foregroundColor(.gray)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
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
                ArtistCollectionDetailView(selectedTrack: artistCollection)
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

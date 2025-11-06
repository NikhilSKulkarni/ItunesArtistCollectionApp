//
//  ArtistCollectionDetailView.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//

import SwiftUI

struct ArtistCollectionDetailView: View {
    var selectedTrack: ArtistCollection
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: selectedTrack.artworkUrl100)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                        ProgressView("Loading image…")
                    }
                    .frame(height: 250)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                        .padding(.horizontal)

                case .failure:
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("Image unavailable")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: 250)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal)

                @unknown default:
                    EmptyView()
                }
            }

            // MARK: - Details
            VStack(alignment: .leading, spacing: 12) {
                Text(selectedTrack.trackName)
                    .font(.title2)
                    .bold()
                Text(selectedTrack.collectionName)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.vertical)
        
    }
}

#Preview {
    ArtistCollectionDetailView(selectedTrack: ArtistCollection(trackId: 1, trackName: "", collectionName: "", artworkUrl100: ""))
}

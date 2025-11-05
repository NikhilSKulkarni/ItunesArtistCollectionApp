//
//  NetworkError.swift
//  ItunesArtistCollection
//
//  Created by Nikhil Subhash Kulkarni on 05/11/25.
//
enum NetworkError: Error, Equatable {
    case invalidUrl
    case decodingFailed
    case requestFailed
}


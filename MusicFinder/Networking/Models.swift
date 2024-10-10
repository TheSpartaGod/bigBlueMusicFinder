//
//  Models.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//

import Foundation

struct SearchResponse: Codable {
    var resultCount: Int?
    var results: [MusicEntry]?
}

struct MusicEntry: Codable {
    var artistName, collectionName, trackName: String?
    var releaseDate: String?
    var previewUrl: String? // only use previewUrl so user don't need to link itunes account :P
}

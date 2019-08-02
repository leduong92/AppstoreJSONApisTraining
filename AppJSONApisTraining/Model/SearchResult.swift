//
//  SearchResult.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/2/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
    var formattedPrice: String? //fix data canot comback
    let description: String
    var releaseNotes: String?
    
}

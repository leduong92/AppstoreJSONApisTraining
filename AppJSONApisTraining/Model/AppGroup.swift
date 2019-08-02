//
//  AppGroup.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/2/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

struct AppGroup: Decodable {
    let feed: Feed
}


struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}

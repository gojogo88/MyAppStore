//
//  AppGroup.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/27.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
  let feed: Feed
}

struct Feed: Decodable {
  let title: String
  let results: [FeedResult]
}

struct FeedResult: Decodable {
  let name, artistName, artworkUrl100: String
}

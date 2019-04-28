//
//  SearchResult.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/25.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {
  let trackName: String
  let primaryGenreName: String
  var averageUserRating: Float?
  let screenshotUrls: [String]
  let artworkUrl100: String // app icon
  let formattedPrice: String
  let description: String
  let releaseNotes: String
}


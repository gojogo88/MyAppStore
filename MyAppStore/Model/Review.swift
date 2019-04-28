//
//  Review.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import Foundation

struct Review: Decodable {
  let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
  let entry: [Entry]
}

struct Entry: Decodable {
  let title: Label
  let author: Author
  let content: Label
}

struct Label: Decodable {
  let label: String
}

struct Author: Decodable {
  let name: Label
}

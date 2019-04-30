//
//  TodayMultipleAppsDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayMultipleAppDataSource: NSObject, UICollectionViewDataSource {
  
  let reuseIdentifier = "cellId"
  
  var results = [FeedResult]()
  
  var dataChanged: (() -> Void)?

  func fetchGames(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(AppGroup.self, fromURL: urlString) { (result) in
      self.results = result.feed.results
      self.dataChanged?()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  min(4, results.count)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultipleAppCell
    cell.app = self.results[indexPath.item]
    return cell
  }
}

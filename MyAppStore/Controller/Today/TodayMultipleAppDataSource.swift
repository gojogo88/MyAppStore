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
  
  var apps = [FeedResult]()
  
  var dataChanged: (() -> Void)?
  
  var fullScreen = false

  func fetchGames(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(AppGroup.self, fromURL: urlString) { (result) in
      self.apps = result.feed.results
      self.dataChanged?()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if fullScreen {
      return apps.count
    }
    return  min(4, apps.count)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultipleAppCell
    cell.app = self.apps[indexPath.item]
    return cell
  }
  
}

//
//  AppsHorizontalDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsHorizontalDataSource: NSObject, UICollectionViewDataSource {
  
  let reuseIdentifier = "Cell"
  
  var appGroup: AppGroup?
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppsRowCell
    
    let app = appGroup?.feed.results[indexPath.item]
    cell.appFeedResult = app
    
    return cell
  }
}

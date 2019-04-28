//
//  ReviewControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class ReviewControllerDataSource: NSObject, UICollectionViewDataSource {
  
  var dataChanged: (() -> Void)?
  
  var reviews: Review? {
    didSet {
      dataChanged?()
    }
  }
  
  let reuseIdentifier = "cell"
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return reviews?.feed.entry.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewCell
    
    let entry = self.reviews?.feed.entry[indexPath.item]
    
    cell.entry = entry
    
    return cell
  }
  
  
}

//
//  TodayControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayControllerDataSource: NSObject, UICollectionViewDataSource {
  let reuseIdentifier = "cellId"
  
  var dataChanged: (() -> Void)?
  
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCell
    
    return cell
  }
}

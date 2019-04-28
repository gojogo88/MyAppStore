//
//  AppsDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsPageDataSource: NSObject, UICollectionViewDataSource {

  let reuseIdentifier = "Cell"
  
  let headerId = "headerId"
  
  var groups = [AppGroup]()
  
  //var dataChanged: (() -> Void)?
  
  let dispatchGroup = DispatchGroup()
  
  // MARK: - Fetch JSON Data
  func fetchAppGroup(_ urlString: String) {
    
    dispatchGroup.enter()
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(AppGroup.self, fromURL: urlString) { (appGroup) in
      self.groups.append(appGroup)
      //self.dataChanged?()
      self.dispatchGroup.leave()
    }
  }
  
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppsGroupCell
    
    let appGroup = groups[indexPath.item]
    cell.titleLabel.text = appGroup.feed.title
    cell.horizontalController.dataSource.appGroup = appGroup
    cell.horizontalController.collectionView.reloadData()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
    
    //header.appHeaderHorizontalController.dataSource.socialApps = 
    
    return header
  }
}

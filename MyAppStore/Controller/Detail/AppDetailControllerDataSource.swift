//
//  AppDetailControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppDetailControllerDataSource: NSObject, UICollectionViewDataSource {
  
  let reuseIdentifier = "cell"
  
  let previewIdentifier = "previewCell"
  
  var dataChanged: (() -> Void)?
  
  var result: Result!
  
  // MARK: - Fetch JSON Data
  func fetchAppDetails(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(Result.self, fromURL: urlString) { (appDetails) in
      self.result = appDetails
      self.dataChanged?()
    }
  }
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == 0{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppDetailCell
    
      cell.appResult = result
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewIdentifier, for: indexPath) as! PreviewCell
      
      cell.horizontalController.dataSource.appResult = self.result
      
      return cell
    }
  }
  
}

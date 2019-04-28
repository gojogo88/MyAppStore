//
//  PreviewScreenshotDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class PreviewScreenshotDataSource: NSObject, UICollectionViewDataSource {
  
  var appResult: Result? {
    didSet {
      dataChanged?()
    }
    
  }
  
  var dataChanged: (() -> Void)?
  
  let reuseIdentifier = "cell"
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appResult?.screenshotUrls.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScreenshotCell
    
    let screenshotUrl = self.appResult?.screenshotUrls[indexPath.item]
    cell.imageView.sd_setImage(with:
      URL(string: screenshotUrl ?? ""))
        
    return cell
  }
  
  
}

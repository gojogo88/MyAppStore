//
//  AppsHeaderControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/27.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsHeaderControllerDataSource: NSObject, UICollectionViewDataSource {
  
  let reuseIdentifier = "cellId"
  
  var socialApps = [SocialApp]()
  
  var dataChanged: (() -> Void)?
  
  // MARK: - Fetch JSON Data
  func fetchSocial(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode([SocialApp].self, fromURL: urlString) { (socialApp) in
      self.socialApps = socialApp
      self.dataChanged?()
    }
  }
  
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return socialApps.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppHeaderCell
    let app = socialApps[indexPath.item]
    
    cell.companyLabel.text = app.name
    cell.titleLabel.text = app.tagline
    
    let url = URL(string: app.imageUrl)
    cell.imageView.sd_setImage(with: url)
    
    return cell
  }
}

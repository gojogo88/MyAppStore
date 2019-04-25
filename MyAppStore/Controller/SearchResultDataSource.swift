//
//  SearchResultDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/25.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class SearchResultDataSource: NSObject, UICollectionViewDataSource {
  
  var appResults = [Result]()
  var dataChanged: (() -> Void)?
  
  let reuseIdentifier = "Cell"
  
  func fetchITunesApps(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(SearchResult.self, fromURL: urlString) { searchResult in
      self.appResults = searchResult.results
      
      self.dataChanged?()
    }
  }
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appResults.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
    
    configure(cell, at: indexPath)
    
    return cell
  }
  
  fileprivate func configure(_ cell: SearchResultCell, at indexPath: IndexPath) {
    
    let appResult = appResults[indexPath.item]
    cell.nameLabel.text = appResult.trackName
    cell.categoryLabel.text = appResult.primaryGenreName
    cell.ratingsLabel.text = "Ratings: \(appResult.averageUserRating ?? 0)"
  }
  
}

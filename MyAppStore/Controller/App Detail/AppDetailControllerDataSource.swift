//
//  AppDetailControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppDetailControllerDataSource: NSObject, UICollectionViewDataSource {
  
  let reuseIdentifier = "detailCellId"
  let previewIdentifier = "previewCellId"
  let reviewIdentifier = "reviewCellId"
  
  var appDetailsFetched: (() -> ())?
  var appReviewsfetched: (() -> ())?
  
  var app: Result?
  var reviews: Review?
  
  // MARK: - Fetch JSON Data
  func fetchAppDetails(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(SearchResult.self, fromURL: urlString) { (result) in
      self.app = result.results.first
      self.appDetailsFetched?()
    }
  }
  
  func fetchAppReviews(_ urlString: String) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(Review.self, fromURL: urlString) { (reviews) in
      self.reviews = reviews
      self.appReviewsfetched?()
    }
  }
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppDetailCell
      cell.appResult = app
      return cell
    } else if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewIdentifier, for: indexPath) as! PreviewCell
      cell.horizontalController.dataSource.appResult = self.app
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewIdentifier, for: indexPath) as! ReviewRowCell
      cell.reviewsController.dataSource.reviews = self.reviews
      return cell
    }
  }
  
}

//
//  TodayControllerDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayControllerDataSource: NSObject, UICollectionViewDataSource {
  
  var dataChanged: (() -> ())?
  
  var handlePresent: ((UIGestureRecognizer) -> ())?
  
//  let items = [
//    TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single),
//
//    TodayItem.init(category: "SECOND CELL", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple),
//
//    TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single),
//
//    TodayItem.init(category: "MULTIPLE CELL", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple)
//  ]
  
  var items = [TodayItem]()
  
  var topGrossingGroup: AppGroup?
  
  var gamesGroup: AppGroup?
  
  let dispatchGroup = DispatchGroup()
  
  // MARK: - Fetch JSON Data
  func fetchAppGroup(urlString1: String, urlString2: String) {
    
    fetchtopGrossingGroup(urlString1)
    fetchGamesGroup(urlString2)
    
    dispatchGroup.notify(queue: .main) {
      //self.activityIndicatorView.stopAnimating()
      self.items = [
         TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
         
        TodayItem.init(category: "Daily List", title: self.topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.topGrossingGroup?.feed.results ?? []),
        
        TodayItem.init(category: "Daily List", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.gamesGroup?.feed.results ?? []),
        
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: [])
      ]
      
      self.dataChanged?()
    }
    
  }
  
  func fetchtopGrossingGroup(_ urlString1: String) {
    dispatchGroup.enter()
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(AppGroup.self, fromURL: urlString1) { (appGroup) in
      self.topGrossingGroup = appGroup
      self.dispatchGroup.leave()
    }
  }
  
  func fetchGamesGroup(_ urlString2: String) {
    dispatchGroup.enter()
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    decoder.decode(AppGroup.self, fromURL: urlString2) { (appGroup) in
      self.gamesGroup = appGroup
      self.dispatchGroup.leave()
    }
  }
  
  @objc fileprivate func handleMultipleAppTap(gesture: UIGestureRecognizer) {
    handlePresent?(gesture)
  }
  
  // MARK: - CollectionView DataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellId = items[indexPath.item].cellType.rawValue
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
    cell.todayItem = items[indexPath.item]
    
    (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppTap)))
    
    (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.isUserInteractionEnabled = false
    
    return cell
    
    // multiple app cell
    // hard coded check
    //        if indexPath.item == 0 {
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppCellId, for: indexPath) as! TodayMultipleAppCell
    //            cell.todayItem = items[indexPath.item]
    //            return cell
    //        }
    //
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
    //        cell.todayItem = items[indexPath.item]
    //        return cell
  }
}

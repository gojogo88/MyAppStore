//
//  TodayMultipleAppsController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayMultipleAppController: BaseListController {
  
  let dataSource = TodayMultipleAppDataSource()
  
  fileprivate let spacing: CGFloat = 16
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = dataSource
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = false
    
    //Register cel classes
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
    
    dataSource.fetchGames("https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json")
  }
  
}

extension TodayMultipleAppController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = (view.frame.height - 3 * spacing) / 4
    
    return .init(width: view.frame.width, height: height)
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
}

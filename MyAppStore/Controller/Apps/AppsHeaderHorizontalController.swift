//
//  AppsHeaderHorizontalController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/27.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController {
  
  let dataSource = AppsHeaderControllerDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource

    // Register cell classes
    self.collectionView!.register(AppHeaderCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
  
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
    
    dataSource.fetchSocial("https://api.letsbuildthatapp.com/appstore/social")
    
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
}


extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return .init(top: 0, left: 16, bottom: 0, right: 16)
//  }
}

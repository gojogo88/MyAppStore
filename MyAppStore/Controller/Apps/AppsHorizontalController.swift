//
//  AppsHorizontalController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController {
  
  let dataSource = AppsHorizontalDataSource()
  
  let topBottomPadding: CGFloat = 12
  let interimSpacing: CGFloat = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource
    
    // Register cell classes
    self.collectionView!.register(AppsRowCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
  }
  
  
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.height - 2 * topBottomPadding - 2 * interimSpacing) / 3
    return .init(width: view.frame.width - 40, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interimSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 12, bottom: topBottomPadding, right: 12)
  }
}

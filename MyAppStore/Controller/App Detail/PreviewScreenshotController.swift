//
//  PreviewScreenshotController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class PreviewScreenshotController: HorizontalSnappingController {
 
  let dataSource = PreviewScreenshotDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    // Register cell classes
    self.collectionView!.register(ScreenshotCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
  }
}

extension PreviewScreenshotController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: 250, height: view.frame.height)
  }
}

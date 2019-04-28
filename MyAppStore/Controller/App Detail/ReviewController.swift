//
//  ReviewController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class ReviewController: HorizontalSnappingController {
  
  let dataSource = ReviewControllerDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    // Register cell classes
    self.collectionView!.register(ReviewRowCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
  }
}

extension ReviewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}

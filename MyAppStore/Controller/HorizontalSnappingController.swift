//
//  HorizontalSnappingController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
  init() {
    let layout = SnappingLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    collectionView.decelerationRate = .fast
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

/*
class SnappingLayout: UICollectionViewFlowLayout {
  //snap behavior
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    guard let collectionView = self.collectionView else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    
    let itemWidth = collectionView.frame.width - 48
    let itemSpace = itemWidth + minimumLineSpacing
    var pageNumber = round(collectionView.contentOffset.x / itemSpace)
    
    let vX = velocity.x
    if vX > 0 {
      pageNumber += 1
    } else if vX < 0 {
      pageNumber -= 1
    }
    
    let nearestPageOffset = pageNumber * itemSpace
    return CGPoint(x: nearestPageOffset, y: parent.y)
  }
}
*/

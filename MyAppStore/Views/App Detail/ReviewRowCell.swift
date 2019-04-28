//
//  ReviewRowCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
  
  let reviewController = ReviewController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .yellow
    
    addSubview(reviewController.view)
    reviewController.view.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

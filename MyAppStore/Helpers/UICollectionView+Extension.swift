//
//  UICollectionView+Extension.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func setupEmptyState(with message: UILabel){
    
     //self.backgroundView = enterSearchTermLabel
    addSubview(message)
    message.fillSuperview(padding: .init(top: 120, left: 50, bottom: 0, right: 50))
  }
  
  func restore(with message: UILabel) {
    message.removeFromSuperview()
  }
}

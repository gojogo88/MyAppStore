//
//  AppsPageHeader.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/27.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
  
  let appHeaderHorizontalController = AppsHeaderHorizontalController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
        
    addSubview(appHeaderHorizontalController.view)
    appHeaderHorizontalController.view.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

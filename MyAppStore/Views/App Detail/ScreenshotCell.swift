//
//  ScreenshotCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
  
  let imageView = UIImageView(cornerRadius: 12)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //imageView.backgroundColor = .purple
    addSubview(imageView)
    imageView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

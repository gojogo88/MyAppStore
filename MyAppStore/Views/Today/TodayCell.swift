//
//  TodayCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
  
  let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 16
    
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.centerInSuperview(size: .init(width: 250, height: 250))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

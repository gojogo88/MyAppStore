//
//  PreviewCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
  
  let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
  let horizontalController = PreviewScreenshotController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .red
    
    addSubview(previewLabel)
    previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    addSubview(horizontalController.view)
    horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

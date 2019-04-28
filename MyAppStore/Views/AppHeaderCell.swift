//
//  AppHeaderCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/27.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {

  let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
  let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .boldSystemFont(ofSize: 24))
  
  let imageView = UIImageView(cornerRadius: 8)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    titleLabel.numberOfLines = 2
    companyLabel.textColor = .blue
    
    let stackView = VerticalStackView(arrangedSubviews: [
      companyLabel, titleLabel, imageView
    ], spacing: 12)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

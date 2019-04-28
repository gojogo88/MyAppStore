//
//  ReviewCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
  
  var entry: Entry! {
    didSet {
      titleLabel.text = entry.title.label
      authorLabel.text = entry.author.name.label
      bodyLabel.text = entry.content.label
    }
  }
  
  let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
  
  let authorLabel = UILabel(text: "Author", font: .boldSystemFont(ofSize: 16))
  
  let starsLabel = UILabel(text: "Stars", font: .boldSystemFont(ofSize: 14))
  
  let bodyLabel = UILabel(text: "review body\nReview Body\nReview body\n", font: .boldSystemFont(ofSize: 16), numberOfLines: 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .lightGray
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        titleLabel, authorLabel
        ], customSpacing: 8),
      starsLabel,
      bodyLabel
      ], spacing: 12)
    titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    authorLabel.textAlignment = .right
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

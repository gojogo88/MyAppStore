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
      
      for (index, view) in starsStackView.arrangedSubviews.enumerated() {
        if let ratingInt = Int(entry.rating.label) {
          view.alpha = index >= ratingInt ? 0 : 1
        }
      }
    }
  }
  
  let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
  
  let authorLabel = UILabel(text: "Author", font: .boldSystemFont(ofSize: 16))
  
  let starsLabel = UILabel(text: "Stars", font: .boldSystemFont(ofSize: 14))
  
  let bodyLabel = UILabel(text: "review body\nReview Body\nReview body\n", font: .boldSystemFont(ofSize: 18), numberOfLines: 5)
  
  let starsStackView: UIStackView = {
    var arrangedSubviews = [UIView]()
    (0..<5).forEach({ (_) in
      let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
      imageView.constrainWidth(constant: 24)
      imageView.constrainHeight(constant: 24)
      arrangedSubviews.append(imageView)
    })
    arrangedSubviews.append(UIView())
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        titleLabel, authorLabel
        ], customSpacing: 8),
      starsStackView,
      bodyLabel
      ], spacing: 12)
    
    titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    authorLabel.textAlignment = .right
    
    addSubview(stackView)
    stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

//
//  TodayCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
  
  override var todayItem: TodayItem! {
    didSet {
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      imageView.image = todayItem.image
      descriptionLabel.text = todayItem.description
      
      backgroundColor = todayItem.backgroundColor
      backgroundView?.backgroundColor = todayItem.backgroundColor
    }
  }
  
  let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
  
  let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
  
  let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
  
  var topConstraint: NSLayoutConstraint!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    //clipsToBounds = true
    layer.cornerRadius = 16
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    
    let imageContainerView = UIView()
    imageContainerView.addSubview(imageView)
    imageView.centerInSuperview(size: .init(width: 240, height: 240))
    
    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel, titleLabel, imageContainerView, descriptionLabel
      ], spacing: 8)
    addSubview(stackView)
    
    stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
    self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
    self.topConstraint.isActive = true
    //stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

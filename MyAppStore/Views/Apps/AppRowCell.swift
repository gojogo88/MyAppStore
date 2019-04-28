//
//  AppRowCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsRowCell: UICollectionViewCell {
  
  let imageView = UIImageView(cornerRadius: 8)
  
  let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20))
  let companyLabel = UILabel(text: "Company Name", font: .boldSystemFont(ofSize: 13))
  
  let getButton = UIButton(title: "GET")
  
  var appFeedResult: FeedResult! {
    didSet {
      nameLabel.text = appFeedResult.name
      companyLabel.text = appFeedResult.artistName
      
      let url = URL(string: appFeedResult.artworkUrl100)
      imageView.sd_setImage(with: url)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
        
    imageView.backgroundColor = .purple
    //imageView.widthAnchor.constraint(equalToConstant: 64)
    imageView.constrainWidth(constant: 64)
    imageView.constrainHeight(constant: 64)
    
    getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)
    getButton.layer.cornerRadius = 16
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView,
      VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
      getButton
      ])
    stackView.spacing = 16
    stackView.alignment = .center
    
    addSubview(stackView)
    stackView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


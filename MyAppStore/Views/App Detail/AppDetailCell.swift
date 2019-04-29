//
//  AppDetailCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
  
  var appResult: Result? {
    didSet {
      nameLabel.text = appResult?.trackName
      releaseNotesLabel.text = appResult?.releaseNotes
      
      let url = URL(string: appResult?.artworkUrl100 ?? "")
      appIconImageView.sd_setImage(with: url)
      
      priceButton.setTitle(appResult?.formattedPrice, for: .normal)
    }
  }
  
  let appIconImageView = UIImageView(cornerRadius: 16)
  
  let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
  
  let priceButton = UIButton(title: "$4.99")
  
  let whatsnewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
  
  let releaseNotesLabel = UILabel(text: "Release Notes", font: .boldSystemFont(ofSize: 18), numberOfLines: 0)

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    print("I'm in appdetail cell")
    appIconImageView.backgroundColor = .red
    appIconImageView.constrainWidth(constant: 140)
    appIconImageView.constrainHeight(constant: 140)
    
    priceButton.backgroundColor = .blue
    priceButton.constrainWidth(constant: 80)
    priceButton.constrainHeight(constant: 32)
    priceButton.layer.cornerRadius = 32 / 2
    priceButton.setTitleColor(.white, for: .normal)
    priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        appIconImageView,
        VerticalStackView(arrangedSubviews: [
          nameLabel,
          UIStackView(arrangedSubviews: [priceButton, UIView()]),
          UIView() //for spacing
          ], spacing: 12)
        ], customSpacing: 20),
      whatsnewLabel,
      releaseNotesLabel
      ], spacing: 16)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

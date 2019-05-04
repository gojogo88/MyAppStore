//
//  TodayMultipleAppCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
  
  override var todayItem: TodayItem! {
    didSet {
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      
      multipleAppController.dataSource.apps = todayItem.apps
      multipleAppController.collectionView.reloadData()
    }
  }
  
  let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
  
  let multipleAppController = TodayMultipleAppController(mode: .small)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 16
    
    multipleAppController.view.backgroundColor = .red
    
    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      multipleAppController.view
      ], spacing: 12)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

//
//  AppFullScreenHeaderCell.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
  
  let todayCell = TodayCell()
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(todayCell)
    todayCell.fillSuperview()
    
    addSubview(closeButton)
    closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 80, height: 38))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

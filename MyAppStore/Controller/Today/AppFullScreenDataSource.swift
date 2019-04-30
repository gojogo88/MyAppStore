//
//  AppFullScreenDataSource.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppFullScreenDataSource: NSObject, UITableViewDataSource {
  
  let reuseIdentifier = "cellId"
  
  let headerIdentifier = "headerCellId"
  
  var dismissHandler: (() ->())?
  
  var todayItem: TodayItem?
  
  @objc fileprivate func handleDismiss(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let headerCell = AppFullScreenHeaderCell()
      headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      return headerCell
    }
    
    let cell = AppFullScreenDescriptionCell()
    return cell
  }
  
}

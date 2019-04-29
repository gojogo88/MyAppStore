//
//  AppFullScreenController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
  
  let dataSource = AppFullScreenDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
    
    // Register cell classes
    tableView.register(AppFullScreenDescrptionCell.self, forCellReuseIdentifier: dataSource.reuseIdentifier)
    
    tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: dataSource.headerIdentifier)
    
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView() // removes lines
    tableView.showsVerticalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = false
    
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 450
    }
    return super.tableView(tableView, heightForRowAt: indexPath)
  }
  
//  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let header = TodayCell()
//    
//    return header
//  }
//  
//  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 450
//  }
  
  
}

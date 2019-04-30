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
    tableView.register(AppFullScreenDescriptionCell.self, forCellReuseIdentifier: dataSource.reuseIdentifier)
    
    tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: dataSource.headerIdentifier)
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    
    let height = UIApplication.shared.statusBarFrame.height
    tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    
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

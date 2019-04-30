//
//  TodayItem.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

struct TodayItem {
  
  let category: String
  let title: String
  let image: UIImage
  let description: String
  let backgroundColor: UIColor
  
  // enum
  let cellType: CellType
  
  enum CellType: String {
    case single, multiple
  }
}

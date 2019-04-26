//
//  UIButton+Extension.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

extension UIButton {
  convenience init(title: String) {
    self.init(type: .system)
    self.setTitle(title, for: .normal)
  }
}

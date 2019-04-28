//
//  UIStackView+Extension.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

extension UIStackView {
  convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
    self.init(arrangedSubviews: arrangedSubviews)
    self.spacing = customSpacing
  }
}

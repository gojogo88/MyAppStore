//
//  BackEnabledNavController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/05/01.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class BackEnabledNavController: UINavigationController, UIGestureRecognizerDelegate {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.interactivePopGestureRecognizer?.delegate = self
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.viewControllers.count > 1
  }
}

//
//  TodayController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/29.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
  
  let dataSource = TodayControllerDataSource()
  
  var appFullScreenController: AppFullScreenController!
  var startingFrame: CGRect?
  
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
    collectionView.dataSource = dataSource
    
    navigationController?.isNavigationBarHidden = true
    
    // Register cell classes
    self.collectionView!.register(TodayCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
  }
  
  @objc func handleRemoveRedView() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.appFullScreenController.tableView.contentOffset = .zero
      
      guard let startingFrame = self.startingFrame else { return }
      self.topConstraint?.constant = startingFrame.origin.y
      self.leadingConstraint?.constant = startingFrame.origin.x
      self.widthConstraint?.constant = startingFrame.width
      self.heightConstraint?.constant = startingFrame.height
      
      self.view.layoutIfNeeded()
      
      self.tabBarController?.tabBar.transform = .identity
      
      guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
      
      cell.todayCell.topConstraint.constant = 24
      cell.layoutIfNeeded()
      
    }, completion: { _ in
      self.appFullScreenController.view.removeFromSuperview()
      self.appFullScreenController.remove()
      self.collectionView.isUserInteractionEnabled = true
    })
  }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 64, height: 450)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32  // so equal spacing on each side
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let appFullScreenController = AppFullScreenController()
    appFullScreenController.dataSource.todayItem = dataSource.items[indexPath.row]
    appFullScreenController.dataSource.dismissHandler = {
      self.handleRemoveRedView()
    }
    let fullscreenView = appFullScreenController.view!
    view.addSubview(fullscreenView)
    
    addChild(appFullScreenController)
    
    self.appFullScreenController = appFullScreenController
    
    self.collectionView.isUserInteractionEnabled = false
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // absolute coordindates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    
    self.startingFrame = startingFrame
    
    // auto layout constraint animations
    // 4 anchors
    fullscreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    self.view.layoutIfNeeded()
    
    fullscreenView.layer.cornerRadius = 16
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.topConstraint?.constant = 0
      self.leadingConstraint?.constant = 0
      self.widthConstraint?.constant = self.view.frame.width
      self.heightConstraint?.constant = self.view.frame.height
      
      self.view.layoutIfNeeded() // starts animation
      
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
      
      guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
      
      cell.todayCell.topConstraint.constant = 60
      cell.layoutIfNeeded()
      
      
    }, completion: nil)
  }
}

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
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
      //gesture.view?.frame = self.startingFrame ?? .zero
      
      self.appFullScreenController.tableView.contentOffset = .zero
      
      guard let startingFrame = self.startingFrame else { return }
      
      self.topConstraint?.constant = startingFrame.origin.y
      self.leadingConstraint?.constant = startingFrame.origin.x
      self.widthConstraint?.constant = startingFrame.width
      self.heightConstraint?.constant = startingFrame.height
      
      self.view.layoutIfNeeded()  // starts animation
      
      self.tabBarController?.tabBar.transform = .identity
    }, completion: { _ in
      self.appFullScreenController.view.removeFromSuperview()
      //self.appFullScreenController.removeFromParent()
      self.appFullScreenController.remove()
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
    //animate to full screen
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    let appFullScreenController = AppFullScreenController()
    appFullScreenController.dataSource.dismissHandler = {
      self.handleRemoveRedView()
    }
    
    //let redView = UIView()
    let redView = appFullScreenController.view!
    redView.layer.cornerRadius = 16
    redView.translatesAutoresizingMaskIntoConstraints = false
    redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
    //redView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
    
    view.addSubview(redView)
    
    //addChild(appFullScreenController)
    add(appFullScreenController)
    self.appFullScreenController = appFullScreenController
    
    //absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
    //redView.frame = startingFrame
    
    redView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = redView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = redView.heightAnchor.constraint(equalToConstant: startingFrame.height)

    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    self.view.layoutIfNeeded()
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
      //redView.frame = self.view.frame
      self.topConstraint?.constant = 0
      self.leadingConstraint?.constant = 0
      self.widthConstraint?.constant = self.view.frame.width
      self.heightConstraint?.constant = self.view.frame.height
      
      self.view.layoutIfNeeded()  // starts animation
      
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
    }, completion: nil)
  }
}

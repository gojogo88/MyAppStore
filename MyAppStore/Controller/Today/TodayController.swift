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
  
  static var cellSize: CGFloat = 500
  
  var startingFrame: CGRect?
  
  var anchoredConstraints: AnchoredConstraints?
  
//  var topConstraint: NSLayoutConstraint?
//  var leadingConstraint: NSLayoutConstraint?
//  var widthConstraint: NSLayoutConstraint?
//  var heightConstraint: NSLayoutConstraint?
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView()
    aiv.color = .darkGray
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  let urlString1 = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
  
  let urlString2 = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.setNeedsLayout()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
    collectionView.dataSource = dataSource
    
    navigationController?.isNavigationBarHidden = true
    
    // Register cell classes
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    
    view.addSubview(activityIndicatorView)
    activityIndicatorView.centerInSuperview()
    
    dataSource.dataChanged = { [weak self] in
      self?.activityIndicatorView.stopAnimating()
      self?.collectionView.reloadData()
    }
    
    dataSource.handlePresent = { [weak self] (gesture) in
      
      let collectionView = gesture.view
      
      // figure out which cell we're clicking from
      var superview = collectionView?.superview
      
      while superview != nil {
        if let cell = superview as? TodayMultipleAppCell {
          guard let indexPath = self?.collectionView.indexPath(for: cell) else { return }
          
          let apps = self?.dataSource.items[indexPath.item].apps
          
          let fullController = TodayMultipleAppController(mode: .fullScreen)
          fullController.dataSource.apps = apps ?? []
          self?.present(BackEnabledNavController(rootViewController: fullController), animated: true)
        }
        superview = superview?.superview
      }
    }
    
    dataSource.fetchAppGroup(urlString1: urlString1, urlString2: urlString2)
  }

  @objc func handleRemoveRedView() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.appFullScreenController.tableView.contentOffset = .zero
      
      guard let startingFrame = self.startingFrame else { return }
      
      self.anchoredConstraints?.top?.constant = startingFrame.origin.y
      self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
      self.anchoredConstraints?.width?.constant = startingFrame.width
      self.anchoredConstraints?.height?.constant = startingFrame.height
      
//      self.topConstraint?.constant = startingFrame.origin.y
//      self.leadingConstraint?.constant = startingFrame.origin.x
//      self.widthConstraint?.constant = startingFrame.width
//      self.heightConstraint?.constant = startingFrame.height
      
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
    return .init(width: view.frame.width - 64, height: TodayController.cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32  // so equal spacing on each side
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
  
  fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
    let fullController = TodayMultipleAppController(mode: .fullScreen)
    fullController.dataSource.apps = self.dataSource.items[indexPath.item].apps
    present(BackEnabledNavController(rootViewController: fullController), animated: true)
  }
  
  fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
    let appFullScreenController = AppFullScreenController()
    appFullScreenController.dataSource.todayItem = dataSource.items[indexPath.row]
    appFullScreenController.dataSource.dismissHandler = {
      self.handleRemoveRedView()
    }
    
    appFullScreenController.view.layer.cornerRadius = 16
    self.appFullScreenController = appFullScreenController
  }
  
  fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // absolute coordindates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    
    self.startingFrame = startingFrame
  }
  
  fileprivate func setupAppFullScreenStartingPosition(_ indexPath: IndexPath) {
    let fullScreenView = appFullScreenController.view!
    view.addSubview(fullScreenView)
    
    addChild(appFullScreenController)
    
    self.collectionView.isUserInteractionEnabled = false
    
    setupStartingCellFrame(indexPath)
    
    guard let startingFrame = self.startingFrame else { return }
    
    // auto layout constraint animations (4 anchors)
    self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
    
    
//    fullScreenView.translatesAutoresizingMaskIntoConstraints = false
//    topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
//    leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
//    widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
//    heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
//
//    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    self.view.layoutIfNeeded()
  }
  
  fileprivate func beginAnimationAppFullScreen(_ indexPath: IndexPath) {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.anchoredConstraints?.top?.constant = 0
      self.anchoredConstraints?.leading?.constant = 0
      self.anchoredConstraints?.width?.constant = self.view.frame.width
      self.anchoredConstraints?.height?.constant = self.view.frame.height
      
//      self.topConstraint?.constant = 0
//      self.leadingConstraint?.constant = 0
//      self.widthConstraint?.constant = self.view.frame.width
//      self.heightConstraint?.constant = self.view.frame.height
      
      self.view.layoutIfNeeded() // starts animation
      
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
      
      guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
      
      cell.todayCell.topConstraint.constant = 48
      cell.layoutIfNeeded()
      
      
    }, completion: nil)
  }
  
  fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
    // step 1
    setupSingleAppFullScreenController(indexPath)
    
    // step 2: setup fullscreen in its starting position
    setupAppFullScreenStartingPosition(indexPath)
    
    // step 3: fullScreen animation
    beginAnimationAppFullScreen(indexPath)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    switch dataSource.items[indexPath.item].cellType {
    case .multiple:
      showDailyListFullScreen(indexPath)
    default:
      showSingleAppFullScreen(indexPath: indexPath)
    }
  }
}

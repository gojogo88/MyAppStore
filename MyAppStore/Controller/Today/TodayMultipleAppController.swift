//
//  TodayMultipleAppsController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/30.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

enum Mode {
  case small, fullScreen
}

class TodayMultipleAppController: BaseListController {
  
  let dataSource = TodayMultipleAppDataSource()
  
  fileprivate let spacing: CGFloat = 16
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    button.tintColor = .darkGray
    button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return button
  }()
  
  fileprivate let mode: Mode
  
  override var prefersStatusBarHidden: Bool { return true }
  
  init(mode: Mode) {
    self.mode = mode
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = dataSource
    collectionView.backgroundColor = .white
    
    //Register cel classes
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
  dataSource.fetchGames("https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json")
    
    if mode == .fullScreen {
      setupCloseButton()
      dataSource.fullScreen = true
      navigationController?.isNavigationBarHidden = true
    } else {
      collectionView.isScrollEnabled = false
      dataSource.fullScreen = false
    }
  }
  
  fileprivate func setupCloseButton() {
    view.addSubview(closeButton)
    closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 60, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
  }
  
  @objc func handleDismiss() {
    dismiss(animated: true)
  }
}

extension TodayMultipleAppController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = self.dataSource.apps[indexPath.item].id
    let appDetailController = AppDetailController(appId: appId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = 68 //(view.frame.height - 3 * spacing) / 4
    
    if mode == .fullScreen {
      return .init(width: view.frame.width - 48, height: height)
    }
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullScreen {
      return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    return .zero
  }
}

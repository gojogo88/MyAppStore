//
//  AppDetailController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/28.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
  
  let dataSource = AppDetailControllerDataSource()
  
  var appId: String! {
    didSet {
      //print("here is my addID:", appId)
      let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
      dataSource.fetchAppDetails(urlString)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
    
    self.collectionView!.register(AppDetailCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    self.collectionView!.register(PreviewCell.self, forCellWithReuseIdentifier: dataSource.previewIdentifier)
    
    self.collectionView!.register(ReviewRowCell.self, forCellWithReuseIdentifier: dataSource.reviewIdentifier)
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
    
    dataSource.fetchAppReviews("https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?1=en&cc=us")
  }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var height: CGFloat = 280
    
    if indexPath.item == 0 {
      //calculate cell height for auto-resizing
      let size: CGSize = .init(width: view.frame.width, height: .greatestFiniteMagnitude)
      let dummyCell = AppDetailCell(frame: .init(origin: .zero, size: size))
      dummyCell.appResult = dataSource.result
      dummyCell.layoutIfNeeded()
    
      let estimatedSize = dummyCell.systemLayoutSizeFitting(size)
      height = estimatedSize.height
    } else if indexPath.item == 1 {
      height = 500
    } else {
      height = 280
    }
    return .init(width: view.frame.width, height: height)
    
//    let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//    dummyCell.appResult = dataSource.result
//    dummyCell.layoutIfNeeded()
//
//    let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
//    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}

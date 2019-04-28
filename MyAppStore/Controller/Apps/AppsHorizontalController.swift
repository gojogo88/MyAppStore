//
//  AppsHorizontalController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
  
  let dataSource = AppsHorizontalDataSource()
  
  let topBottomPadding: CGFloat = 12
  let interimSpacing: CGFloat = 10
  
  var didSelectHandler: ((FeedResult) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource
    
    // Register cell classes
    self.collectionView!.register(AppsRowCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let margins = topBottomPadding * 2
    let spacing = interimSpacing * 2
    let height = (view.frame.height - margins - spacing) / 3
    return .init(width: view.frame.width - 40, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interimSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let app = dataSource.appGroup?.feed.results[indexPath.item] {
      didSelectHandler?(app)
      
    }
//    let redController = UIViewController()
//    redController.view.backgroundColor = .red
//    self.navigationController?.pushViewController(redController, animated: true)
  }
}

//
//  AppsController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/26.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {

  let dataSource = AppsPageDataSource()
  
  var appgroups = [AppGroup]()
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.color = .black
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource
    
    // Register cell classes
    self.collectionView!.register(AppsGroupCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    self.collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: dataSource.headerId)

    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()
    
//    dataSource.dataChanged = { [weak self] in
//      self?.collectionView.reloadData()
//    }
  dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json")

  dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json")

  dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json")

    dataSource.dispatchGroup.notify(queue: .main) {
      self.activityIndicatorView.stopAnimating()
      self.collectionView.reloadData()
    }
    //fetchData()
  }
  
  /*
  func fetchData() {
    let dispatchGroup = DispatchGroup()
    
     dispatchGroup.enter()
    dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json")
    dispatchGroup.leave()
    
    dispatchGroup.enter()
    dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json")
    dispatchGroup.leave()
    
    dispatchGroup.enter()
    dataSource.fetchAppGroup("https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json")
    dispatchGroup.leave()
    
        dispatchGroup.notify(queue: .main) {
          self.collectionView.reloadData()
        }

  }
  */
}

extension AppsPageController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
}

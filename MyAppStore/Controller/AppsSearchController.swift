//
//  AppsSearchController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/25.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {

  let dataSource = SearchResultDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .white

    collectionView.dataSource = dataSource
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
    
    // Register cell classes
    self.collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    dataSource.fetchITunesApps("https://itunes.apple.com/search?term=instagram&entity=software")
    
  }

  
  // MARK: - Init
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }
}


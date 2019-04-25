//
//  AppsSearchController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/25.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {

  fileprivate let reuseIdentifier = "Cell"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .white

    // Register cell classes
    self.collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
  }

  // MARK: - CollectionView Datasource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
  
    
    return cell
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

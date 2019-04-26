//
//  AppsSearchController.swift
//  MyAppStore
//
//  Created by Jonathan Go on 2019/04/25.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class AppsSearchController: BaseListController {

  let dataSource = SearchResultDataSource()
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  fileprivate let enterSearchTermLabel: UILabel = {
    let label = UILabel()
    label.text = "Please enter search term above..."
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .white
    collectionView.dataSource = dataSource
    
    dataSource.dataChanged = { [weak self] in
      self?.collectionView.reloadData()
    }
    
    // Register cell classes
    self.collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
    
    collectionView.addSubview(enterSearchTermLabel)
    enterSearchTermLabel.fillSuperview(padding: .init(top: 130, left: 50, bottom: 0, right: 50))
    
    setupSearchBar()
  }

  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }
}

extension AppsSearchController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    let searchText = searchText.replacingOccurrences(of: " ", with: "+")
    
    //throttle first
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
      //fire the search
      self.enterSearchTermLabel.isHidden = true
      self.dataSource.fetchITunesApps(searchTerm: searchText)
    })
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    enterSearchTermLabel.isHidden = false
  }
}

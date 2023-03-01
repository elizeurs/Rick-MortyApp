//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 28/02/23.
//

import UIKit

final class RMSearchView: UIView {
  
  let viewModel: RMSearchViewViewModel
  
  // MARK: - Subviews
  
  // SearchInputView(bar, selection buttons)
  
  // No results view
  private let noResultView = RMNoSearchResultsView()
  
  // Results collectionView
  
  // MARK: - Init

  init(frame: CGRect, viewModel: RMSearchViewViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(noResultView)
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      noResultView.widthAnchor.constraint(equalToConstant: 150),
      noResultView.heightAnchor.constraint(equalToConstant: 150),
      noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
      noResultView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}

// MARK: - CollectionView

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}
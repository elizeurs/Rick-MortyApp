//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 28/02/23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
  func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
  
  weak var delegate: RMSearchViewDelegate?
  
  let viewModel: RMSearchViewViewModel
  
  // MARK: - Subviews
  
  // SearchInputView(bar, selection buttons)
  private let searchInputView = RMSearchInputView()
  
  // No results view
  private let noResultView = RMNoSearchResultsView()
  
  // Results collectionView
  
  // MARK: - Init

  init(frame: CGRect, viewModel: RMSearchViewViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(noResultView, searchInputView)
    addConstraints()
    
    searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
    searchInputView.delegate = self
    
    viewModel.registerOptionChangeBlock { tuple in
      // tuple: Option | newValue
      self.searchInputView.update(option: tuple.0, value: tuple.1)
      print(String(describing: tuple))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      // Search input view
      searchInputView.topAnchor.constraint(equalTo: topAnchor),
      searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
      searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
      searchInputView.heightAnchor.constraint(equalToConstant:  viewModel.config.type == .episode ? 55 : 110),
      
      // No results
      noResultView.widthAnchor.constraint(equalToConstant: 150),
      noResultView.heightAnchor.constraint(equalToConstant: 150),
      noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
      noResultView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  public func presentKeyboard() {
    searchInputView.presentKeyboard()
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

// MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
  func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
    delegate?.rmSearchView(self, didSelectOption: option)
  }
}

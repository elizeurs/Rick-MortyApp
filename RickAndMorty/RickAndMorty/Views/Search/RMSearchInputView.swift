//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 28/02/23.
//

import UIKit

final class RMSearchInputView: UIView {
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()
  
  private var viewModel: RMSearchInputViewViewModel? {
    didSet {
      guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
        return
      }
      let options = viewModel.options
      createOptionSelectionViews(options: options)
    }
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemPink
    addSubview(searchBar)
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: topAnchor),
      searchBar.leftAnchor.constraint(equalTo: leftAnchor),
      searchBar.rightAnchor.constraint(equalTo: rightAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: 58)
    ])
  }
  
  private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
    for option in options {
      print(option.rawValue)
    }
  }
  
  public func configure(with viewModel: RMSearchInputViewViewModel) {
    searchBar.placeholder = viewModel.searchPlaceholderText
    // TODO: Fix height of input view for episode with no options
    self.viewModel = viewModel
  }
}

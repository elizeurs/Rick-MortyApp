//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 17/02/23.
//

import UIKit

class RMEpisodeDetailView: UIView {
  
  private var viewModel: RMEpisodeDetailViewViewModel?
  
  private var collectionView: UICollectionView?
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  
  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemRed
    self.collectionView = createCollectionView()
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("Unsupported")
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
    
    ])
  }
  
  private func createCollectionView() -> UICollectionView {
    return UICollectionView()
  }
  
  // MARK: - Public
  
  public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
    
  }
}

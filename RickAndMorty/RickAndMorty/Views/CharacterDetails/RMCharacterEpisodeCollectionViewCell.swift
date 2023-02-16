//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
  static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBlue
    contentView.layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func setUpConstraints() {
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
    viewModel.registerForData { data in
      print(data.name)
      print(data.air_date)
      print(data.episode)
//      print(String(describing: data))
    }
    viewModel.fetchEpisode()
  }
}

//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
  static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func setUpConstraints() {
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
    
  }

}

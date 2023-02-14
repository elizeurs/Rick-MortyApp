//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
  public let value: String
  public let title: String
  
  init(
    value: String,
    title: String
  ) {
    self.value = value
    self.title = title
  }
}

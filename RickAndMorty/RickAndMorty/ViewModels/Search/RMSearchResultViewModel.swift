//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 07/03/23.
//

import Foundation

enum RMSearchResultViewModel {
  case characters([RMCharacterCollectionViewCellViewModel])
  case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
  case locations([RMLocationTableViewCellViewModel])
}

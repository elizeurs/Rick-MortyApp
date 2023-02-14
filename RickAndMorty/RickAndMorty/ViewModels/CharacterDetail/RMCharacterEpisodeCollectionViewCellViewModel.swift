//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
  private let episodeDataUrl: URL?
  
  init(episodeDataUrl: URL?) {
    self.episodeDataUrl = episodeDataUrl
  }
}

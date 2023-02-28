//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 28/02/23.
//

import Foundation

// Responsabilities:
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel {
  let config: RMSearchViewController.Config
  
  init(config: RMSearchViewController.Config) {
    self.config = config
  }
}

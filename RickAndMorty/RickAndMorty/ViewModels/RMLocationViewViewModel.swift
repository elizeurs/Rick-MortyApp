//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 26/02/23.
//

import Foundation

final class RMLocationViewViewModel {
  
  private var locations: [RMLocation] = []
  
  // Location response info
  // Will contain next url, if present
  
  private var cellViewModels: [String] = []
  
  init() {}
  
  public func fetchLocations() {
//    let request = RMRequest(endpoint: .location)
    RMService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
      switch result {
      case .success(let model):
        break
      case .failure(let error):
        break
      }
    }
  }
  
  private var hasMoreResults: Bool {
    return false
  }
}


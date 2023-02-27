//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 26/02/23.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
  func didFetchInitialLocations()
}

final class RMLocationViewViewModel {
  
  // weak: avoid memory leak here
  weak var delegate: RMLocationViewViewModelDelegate?
  
  private var locations: [RMLocation] = [] {
    didSet {
      for location in locations {
        let cellViewModel = RMLocationTableViewCellViewModel(location: location)
        if !cellViewModels.contains(cellViewModel) {
          cellViewModels.append(cellViewModel)
        }
      }
    }
  }
  
  // Location response info
  // Will contain next url, if present
  private var apiInfo: RMGetAllLocationsResponse.Info?
  
  // private(set) - only this class has the authority to assign.
  public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
  
  init() {}
  
  public func fetchLocations() {
//    let request = RMRequest(endpoint: .location)
    RMService.shared.execute(
      .listLocationsRequest,
      expecting: RMGetAllLocationsResponse.self
    ) { [weak self] result in
      switch result {
      case .success(let model):
        self?.apiInfo = model.info
        self?.locations = model.results
        DispatchQueue.main.async {
          self?.delegate?.didFetchInitialLocations()
        }
      case .failure(let error):
        break
      }
    }
  }
  
  private var hasMoreResults: Bool {
    return false
  }
}


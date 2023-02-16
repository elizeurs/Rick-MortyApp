//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import Foundation

protocol RMEpisodeDataRender {
  var name: String { get }
  var air_date: String { get }
  var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
  private let episodeDataUrl: URL?
  private var isFetching = false
  private var dataBlock: ((RMEpisodeDataRender) -> Void)?
  
  private var episode: RMEpisode? {
    didSet {
      guard let model = episode else {
        return
      }
      dataBlock?(model)
    }
  }
  
  // MARK: - Init
  
  init(episodeDataUrl: URL?) {
    self.episodeDataUrl = episodeDataUrl
  }
  
  // MARK: - Public
  
  // block could be called completion too.
  public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
    self.dataBlock = block
  }
  
  public func fetchEpisode() {
    guard !isFetching else {
      if let model = episode {
        dataBlock?(model)
      }
      return
    }
    
//    print(episodeDataUrl)
    
    guard let url = episodeDataUrl,
          let request = RMRequest(url: url) else {
      return
    }
    
    isFetching = true
    
    RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
      switch result {
      case .success(let model):
        // we are updating the ui, so we want to bump this onto the main queue
        DispatchQueue.main.async {
          self?.episode = model
        }
//        print(String(describing: success.id))
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
}
//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 13/02/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
  private let imageURL: URL?
  
  init(imageUrl: URL?) {
    self.imageURL = imageUrl
  }
  
  public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
    guard let imageURL = imageURL else {
      completion(.failure(URLError(.badURL)))
      return
    }
    RMImageLoader.shared.downloadImage(imageURL, completion: completion)
  }
}

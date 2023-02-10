//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 08/02/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
  func didLoadInitialCharacters()
  func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
  
  public weak var delegate: RMCharacterListViewViewModelDelegate?
  
  private var characters: [RMCharacter] = [] {
    didSet {
      for character in characters {
        let viewModel = RMCharacterCollectionViewCellViewModel(
          characterName: character.name,
          characterStatus: character.status,
          characterImageUrl: URL(string: character.image)
        )
        cellViewModels.append(viewModel)
      }
    }
  }
  
  private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
  
  private var apiInfo: RMGetAllCharactersResponse.Info? = nil
  
  /// Fetch initial set of characters (20)
  public func fetchCharacters() {
    RMService.shared.execute(
      .listCharactersRequests,
      expecting: RMGetAllCharactersResponse.self
    ) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.characters = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialCharacters()
        }
//        print("Example image url: "+String(model.results.first?.image ??  "No Image"))
//        print("Total pages: "+String(model.info.pages))
//        print("Total: "+String(model.info.count))
//        print("Page result count: "+String(model.results.count))
//        print(String(describing: model))
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }
  
  /// Paginate, if additional characters are needed
  public func fetchAdditionalCharacters() {
    // Fetch charactes
  }
  
  public var shouldShowLoadMoreIndicator: Bool {
    return apiInfo?.next != nil
  }
}

// MARK: - CollectionView

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
      for: indexPath
    ) as? RMCharacterCollectionViewCell else {
      fatalError("Unsupported cell")
    }
    cell.configure(with: cellViewModels[indexPath.row])
//    cell.backgroundColor = .systemGreen
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width-30)/2
    return CGSize(width: width, height: width * 1.5
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let character = characters[indexPath.row]
    delegate?.didSelectCharacter(character)
  }
}

// MARK: - ScrollView
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator else {
      return
    }
  }
}


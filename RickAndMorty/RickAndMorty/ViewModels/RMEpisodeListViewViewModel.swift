//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 17/02/23.
//

import Foundation

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
  func didLoadInitialEpisodes()
  func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
  
  func didSelectEpisode(_ episode: RMEpisode)
}

/// View Model to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
  
  public weak var delegate: RMEpisodeListViewViewModelDelegate?
  
  private var isLoadingMoreEpisodes = false
  
  private var episodes: [RMEpisode] = [] {
    didSet {
      for episode in episodes {
//        let viewModel = RMEpisodeCollectionViewCellViewModel(
//          characterName: character.name,
//          characterStatus: character.status,
//          characterImageUrl: URL(string: character.image)
//        )
        if !cellViewModels.contains(viewModel) {
          cellViewModels.append(viewModel)
        }
      }
    }
  }
  
  private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
  
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
  public func fetchAdditionalCharacters(url: URL) {
    guard !isLoadingMoreEpisodes else {
      return
    }
//    print("Fetching more data")
    isLoadingMoreEpisodes = true
    guard let request = RMRequest(url: url) else {
      isLoadingMoreEpisodes = false
      return
    }
    
    // Fetch charactes
    RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let responseModel):
        let moreResults = responseModel.results
        let info = responseModel.info
        strongSelf.apiInfo = info
                
        let originalCount = strongSelf.characters.count
        let newCount = moreResults.count
        let total = originalCount+newCount
        let startingIndex = total - newCount
        let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
          return IndexPath(row: $0, section: 0)
        })
        strongSelf.characters.append(contentsOf: moreResults)
        
        DispatchQueue.main.async {
          strongSelf.delegate?.didLoadMoreCharacters(
            with: indexPathsToAdd
          )
          
           strongSelf.isLoadingMoreCharacters = false
        }
      case .failure(let failure):
//        print(String(describing: failure))
        strongSelf.isLoadingMoreCharacters = false
      }
    }
  }
  
  public var shouldShowLoadMoreIndicator: Bool {
    return apiInfo?.next != nil
  }
}

// MARK: - CollectionView

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: RMEpisodeCollectionViewCell.cellIdentifier,
      for: indexPath
    ) as? RMEpisodeCollectionViewCell else {
      fatalError("Unsupported cell")
    }
    cell.configure(with: cellViewModels[indexPath.row])
//    cell.backgroundColor = .systemGreen
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionFooter,
          let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath
          ) as? RMFooterLoadingCollectionReusableView else {
      fatalError("Unsupported")
    }
    footer.startAnimating()
    return footer
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    guard shouldShowLoadMoreIndicator else {
      return .zero
    }
    return CGSize(width: collectionView.frame.width,
                  height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width-30)/2
    return CGSize(width: width, height: width * 1.5
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let character = episodes[indexPath.row]
    delegate?.didSelectCharacter(character)
  }
}

// MARK: - ScrollView
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator,
          !isLoadingMoreEpisodes,
          !cellViewModels.isEmpty,
          let nextUrlString = apiInfo?.next,
          let url = URL(string: nextUrlString) else {
      return
    }
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
      let offset = scrollView.contentOffset.y
      let totalContentHeight = scrollView.contentSize.height
      let totalScrollViewFixedHeight = scrollView.frame.size.height
      //    print("offset: \(offset)")
      //    print("totalContentHeight: \(totalContentHeight)")
      //    print("totalScrollViewFixedHeight: \(totalScrollViewFixedHeight)")
      
      if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
        //      print("should start fetching more")
        self?.fetchAdditionalCharacters(url: url)
      }
      t.invalidate()
    }
  }
}



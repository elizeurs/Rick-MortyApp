//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 12/03/23.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject {
  func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt index: Int)
}

/// Shows search results UI(table or collection as needed)
final class RMSearchResultsView: UIView {
  
  weak var delegate: RMSearchResultsViewDelegate?
  
  private var viewModel: RMSearchResultViewModel? {
    didSet {
      self.processViewModel()
    }
  }
  
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
    table.isHidden = true
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isHidden = true
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
    collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
    collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
    return collectionView
  }()
  
  
  // TableView ViewModels
  private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
  
  // CollectionView ViewModels
  private var collectionViewCellViewModels: [any Hashable] = []
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isHidden = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(tableView, collectionView)
    addConstraints()
    //    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func processViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    
    switch viewModel.results {
    case .characters(let viewModels):
      self.collectionViewCellViewModels = viewModels
      setUpCollectionView()
//      break
    case .locations(let viewModels):
      setUpTableView(viewModels: viewModels)
//      break
    case .episodes(let viewModels):
      self.collectionViewCellViewModels = viewModels
      setUpCollectionView()
//      break
    }
  }
  
  private func setUpCollectionView() {
    self.tableView.isHidden = true
    self.collectionView.isHidden = false
    collectionView.delegate = self
    collectionView.dataSource = self
    
//    collectionView.backgroundColor = .red
    
    collectionView.reloadData()
  }
  
  private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isHidden = false
    collectionView.isHidden = true
    self.locationCellViewModels = viewModels
//    print(viewModels.count)
    tableView.reloadData()
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leftAnchor.constraint(equalTo: leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
//    tableView.backgroundColor = .systemBrown
  }
  
  public func configure(with viewModel: RMSearchResultViewModel) {
    self.viewModel = viewModel
  }
}

extension RMSearchResultsView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locationCellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
      fatalError("Failed to dequeue RMLocationTableViewCell")
    }
    cell.configure(with: locationCellViewModels[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    delegate?.rmSearchResultsView(self, didTapLocationAt: indexPath.row)
  }
}

// MARK: - CollectionView

extension RMSearchResultsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionViewCellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Character | Episode
    let currentViewModel = collectionViewCellViewModels[indexPath.row]
    if let characterVM = currentViewModel as? RMCharacterCollectionViewCellViewModel {
      // Character cell
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
        for: indexPath
      )as? RMCharacterCollectionViewCell else {
        fatalError("")
      }
      cell.configure(with: characterVM)
      return cell
    }
    
    // Episode
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
      for: indexPath
    ) as? RMCharacterEpisodeCollectionViewCell else {
      fatalError()
    }
    if let episodeVM = currentViewModel as? RMCharacterEpisodeCollectionViewCellViewModel {
      cell.configure(with: episodeVM)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    // Handle cell tap
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let currentViewModel = collectionViewCellViewModels[indexPath.row]
    
    let bounds = collectionView.bounds
    
    if currentViewModel is RMCharacterCollectionViewCellViewModel {
      // Character size
      let width = (bounds.width-30)/2
      return CGSize(
        width: width,
        height: width * 1.5
      )
    }
    
    // Episode
    let width = bounds.width-20
    return CGSize(
      width: width,
      height: 100
    )
  }
}

// MARK: - ScrollViewDelegate

extension RMSearchResultsView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if !locationCellViewModels.isEmpty {
      handleLocationPagination(scrollView: scrollView)
    } else {
      // collectionView
      handleLocationPagination(scrollView: scrollView)
    }
  }
  
  private func handleCharacterOrEpisodePagination(scrollView: UIScrollView) {
    
  }
  
  private func handleLocationPagination(scrollView: UIScrollView) {
    guard let viewModel = viewModel,
    !locationCellViewModels.isEmpty,
    viewModel.shouldShowLoadMoreIndicator,
    !viewModel.isLoadingMoreResults else {
      return
    }

    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
      let offset = scrollView.contentOffset.y
      let totalContentHeight = scrollView.contentSize.height
      let totalScrollViewFixedHeight = scrollView.frame.size.height

      if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
        DispatchQueue.main.async {
          self?.showLoadingIndicator()
        }
        viewModel.fetchAdditionalLocations { [weak self] newResults in
          // Refresh table
          self?.tableView.tableFooterView = nil
          self?.locationCellViewModels = newResults
          self?.tableView.reloadData()
        }
      }
      t.invalidate()
    }
  }
  
  private func showLoadingIndicator() {
    let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
//    footer.backgroundColor = .red
    tableView.tableFooterView = footer
  }
}


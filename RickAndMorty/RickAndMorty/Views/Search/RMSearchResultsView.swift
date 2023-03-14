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
  
  private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isHidden = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(tableView)
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
    
    switch viewModel {
    case .characters(let viewModels):
      setUpCollectionView()
//      break
    case .locations(let viewModels):
      setUpTableView(viewModels: viewModels)
//      break
    case .episodes(let viewModels):
      setUpCollectionView()
//      break
    }
  }
  
  private func setUpCollectionView() {
    
  }
  
  private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.isHidden = false
    self.locationCellViewModels = viewModels
//    print(viewModels.count)
    tableView.reloadData()
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
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

//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 06/02/23.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {
  
  private let primaryView = RMLocationView()
  
  private let viewModel = RMLocationViewViewModel()
  
  // MARK: - Lifecyle

  override func viewDidLoad() {
    super.viewDidLoad()
    primaryView.delegate = self
    view.addSubview(primaryView)
    view.backgroundColor = .systemBackground
    title = "Locations"
    addSearchButton()
    addConstraints()
    viewModel.delegate = self
    viewModel.fetchLocations()
  }
  
  private func addSearchButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  @objc
  private func didTapSearch() {
  }
  
  // MARK: - RMLocationViewDelegate
  
  func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
    let vc = RMLocationDetailViewController(location: location)
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: - LocationViewModel Delegate
  
  func didFetchInitialLocations() {
    primaryView.configure(with: viewModel)
  }
}

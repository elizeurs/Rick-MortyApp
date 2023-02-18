//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 16/02/23.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {
  private let viewModel: RMEpisodeDetailViewViewModel
  
  private let detailView = RMEpisodeDetailView()
  
  // MARK: - Init
  
  init(url: URL?) {
    self.viewModel = .init(endpointUrl: url)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Lifecicle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(detailView)
    addConstraints()
    title = "Episode"
//    view.backgroundColor = .systemGreen
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  @objc
  private func didTapShare() {
    
  }
}

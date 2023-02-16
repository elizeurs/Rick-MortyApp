//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 16/02/23.
//

import UIKit

/// VC to show details about single episode
class RMEpisodeDetailViewController: UIViewController {

  private let url: URL?
  
  // MARK: - Init
  
  init(url: URL?) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Lifecicle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Episode"
    view.backgroundColor = .systemGreen
  }
}

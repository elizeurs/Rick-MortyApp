//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 06/02/23.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
  
  private let characterListView = CharacterListView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Characters"
    view.addSubview(characterListView)
    setUpView()
  }
  
  private func setUpView() {
    NSLayoutConstraint.activate([
      characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

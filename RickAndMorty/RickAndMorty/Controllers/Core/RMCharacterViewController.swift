//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 06/02/23.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Characters"
    
    RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
      switch result {
      case .success(let model):
        print("Total pages: "+String(model.info.pages))
        print("Total: "+String(model.info.count))
        print("Page result count: "+String(model.results.count))
        print(String(describing: model))
      case .failure(let error):
        print(String(describing: error))
      }
    }
    
//    let request = RMRequest(
//      endpoint: .character,
//      queryParameters: [
//        URLQueryItem(name: "name", value: "rick"),
//        URLQueryItem(name: "status", value: "alive")
//      ]
//    )
//    print(request.url)
//
//    RMService.shared.execute(request, expecting: RMCharacter.self) { result in
//      switch result {
//      case .success:
//        break
//      case .failure(let error):
//        print(String(describing: error))
//      }
//    }
  }
}

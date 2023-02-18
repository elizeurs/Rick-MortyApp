//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 18/02/23.
//

import UIKit

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
  
  struct Config {
    enum `Type` {
      case character
      case episode
      case location
    }
    
    let type: `Type`
  }
  
  private let config: Config
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Unsupported")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
      view.backgroundColor = .systemBackground
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

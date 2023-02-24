//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 24/02/23.
//

import UIKit

// Identifiable - gives us a unique id, so in swiftui, actually loops over them.
struct RMSettingsCellViewModel: Identifiable, Hashable {
  let id = UUID()
  
  private let type: RMSettingsOption
  
  // MARK: - Init
  
  init(type: RMSettingsOption) {
    self.type = type
  }
  
  // MARK: - Public
  // image | title

  public var image: UIImage? {
    return type.iconImage
  }
  
  public var title: String {
    return type.displayTitle
  }
  
  public var iconContainerColor: UIColor {
    return type.iconContainerColor
  }
}

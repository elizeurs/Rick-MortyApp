//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 24/02/23.
//

import UIKit

// Identifiable - gives us a unique id, so in swiftui, actually loops over them.
struct RMSettingsCellViewModel: Identifiable {
  let id = UUID()
  
  public let type: RMSettingsOption
  public let onTapHandler: (RMSettingsOption) -> Void
  
  // MARK: - Init
  
  init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
    self.type = type
    self.onTapHandler = onTapHandler
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

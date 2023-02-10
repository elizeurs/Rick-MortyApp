//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 10/02/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
  private let character: RMCharacter
  
  init(character: RMCharacter) {
    self.character = character
  }
  
  public var title: String {
    character.name.uppercased()
  }
}

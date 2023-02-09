//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 07/02/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case `unknown` = "unknown"
  
  var text: String {
    switch self {
    case .alive, .dead:
      return rawValue
    case .unknown:
      return "Unknown"
    }
  }
}

//status  string  The status of the character ('Alive', 'Dead' or 'unknown').

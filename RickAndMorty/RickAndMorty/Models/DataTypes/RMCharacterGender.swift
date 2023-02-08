//
//  RMCharacterGender.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 07/02/23.
//

import Foundation

enum RMCharacterGender: String, Codable {
  case male = "Male"
  case female = "Female"
  case genderless = "Genderless"
  case `unknown` = "unknown"
}

//gender  string  The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').

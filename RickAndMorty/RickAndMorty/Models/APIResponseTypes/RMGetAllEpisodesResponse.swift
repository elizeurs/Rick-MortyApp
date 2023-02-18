//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 18/02/23.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
  struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }
  
  let info: Info
  let results: [RMEpisode]
}

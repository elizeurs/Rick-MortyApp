//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 06/02/23.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
  //status  string  The status of the character ('Alive', 'Dead' or 'unknown').
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
//  let origin: {
//  let name": "Earth",
//  let url": "https://rickandmortyapi.com/api/location/1"
//  },
    let origin: RMOrigin
//  let location": {
//    "name": "Earth",
//    "url": "https://rickandmortyapi.com/api/location/20"
//  },
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

//{
//  "id": 1,
//  "name": "Rick Sanchez",
//  "status": "Alive",
//  "species": "Human",
//  "type": "",
//  "gender": "Male",
//  "origin": {
//    "name": "Earth",
//    "url": "https://rickandmortyapi.com/api/location/1"
//  },
//  "location": {
//    "name": "Earth",
//    "url": "https://rickandmortyapi.com/api/location/20"
//  },
//  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
//  "episode": [
//    "https://rickandmortyapi.com/api/episode/1",
//    "https://rickandmortyapi.com/api/episode/2",
//    // ...
//  ],
//  "url": "https://rickandmortyapi.com/api/character/1",
//  "created": "2017-11-04T18:48:46.250Z"
//}

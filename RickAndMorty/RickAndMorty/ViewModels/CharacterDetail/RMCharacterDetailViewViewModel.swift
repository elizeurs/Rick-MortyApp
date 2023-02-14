//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 10/02/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
  private let character: RMCharacter
  
  enum SectionType {
    case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
    
    case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
    
    case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
  }
  
  public var sections: [SectionType] = []
  
  // MARK: - Init
  
  init(character: RMCharacter) {
    self.character = character
    setUpSections()
  }
  
  private func setUpSections() {
    /*
     let id: Int
     let name: String
   //status string The status of the character ('Alive', 'Dead' or 'unknown').
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
     */
    sections = [
      .photo(viewModel: .init(imageUrl: URL(string: character.image))),
      .information(viewModels: [
        .init(value: character.status.text, title: "Status"),
        .init(value: character.gender.rawValue, title: "Gender"),
        .init(value: character.type, title: "Type"),
        .init(value: character.species, title: "Species"),
        .init(value: character.origin.name, title: "Origin"),
        .init(value: character.location.name, title: "Location"),
        .init(value: character.created, title: "Created"),
        .init(value: "\(character.episode.count)", title: "Total Episodes"),
      ]),
      .episodes(viewModels: character.episode.compactMap ({
        return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
      }))
    ]
  }
  
  private var requestUrl: URL? {
    return URL(string: character.url)
  }
  
  public var title: String {
    character.name.uppercased()
  }
  
  // MARK: - Layouts
  
  public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      )
    )
    item.contentInsets =  NSDirectionalEdgeInsets(top: 0,
                                                  leading: 0,
                                                  bottom: 10,
                                                  trailing: 0)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(0.5)
      ),
      subitems: [item]
    )
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
  
  public func createInfoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.5),
        heightDimension: .fractionalHeight(1.0)
      )
    )
    item.contentInsets =  NSDirectionalEdgeInsets(
      top: 2,
      leading: 2,
      bottom: 2,
      trailing: 2
    )
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(150)
      ),
      subitems: [item, item]
    )
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
  
  public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      )
    )
    item.contentInsets =  NSDirectionalEdgeInsets(
      top: 10,
      leading: 5,
      bottom: 10,
      trailing: 5
    )
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.8),
        heightDimension: .absolute(150)
      ),
      subitems: [item]
    )
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    return section
  }
}

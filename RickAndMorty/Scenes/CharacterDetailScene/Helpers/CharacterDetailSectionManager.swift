//
//  CharacterDetailSectionManager.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

enum CharacterDetailTitleSection: String {
    case avatar
    case description
    case episodes
}

protocol ICharacterDetailSectionManager {
    func createAvatar(icon: String) -> CharacterDetailModel.Response.CharacterDetailSection
    func createDescriptions(
        title: String,
        name: String,
        url: String,
        action: ((String) -> Void)?
    ) -> CharacterDetailModel.Response.CharacterDetailSection
    func createEpisodes(
        episodes: [EpisodeDTO],
        action: @escaping ((String) -> Void)
    ) -> CharacterDetailModel.Response.CharacterDetailSection
}

final class CharacterDetailSectionManager: ICharacterDetailSectionManager {
    func createAvatar(icon: String) -> CharacterDetailModel.Response.CharacterDetailSection {
        let item = CharacterDetailModel.Response.Item.avatar(icon: icon)
        
        return .init(section: .title(title: CharacterDetailTitleSection.avatar.rawValue), items: [item])
    }
    
    func createDescriptions(title: String, name: String, url: String, action: ((String) -> Void)?) -> CharacterDetailModel.Response.CharacterDetailSection {
        let item = CharacterDetailModel.Response.Item.description(title: title, name: name, url: url, action: action)
        
        return .init(section: .title(title: CharacterDetailTitleSection.description.rawValue), items: [item])
    }
    
    func createEpisodes(episodes: [EpisodeDTO], action: @escaping (String) -> Void) -> CharacterDetailModel.Response.CharacterDetailSection {
        let episodeItems = episodes.map { episode in
            CharacterDetailModel.Response.Item.episode(
                name: episode.name,
                airDate: episode.airDate,
                episode: episode.episode,
                url: episode.url,
                action: action)
        }
        
        return .init(section: .title(title: CharacterDetailTitleSection.episodes.rawValue), items: episodeItems)
    }
}

//
//  MainSectionManager.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

enum MainTitleScetion: String {
    case characters
    case locations
    case episodes
}

protocol IMainSectionManager {
    func createCharactersSection(characters: CharactersDTO?, action: @escaping (Int) -> Void) -> MainModel.Response.MainSection
}

final class MainSectionManager: IMainSectionManager {
    func createCharactersSection(characters: CharactersDTO?, action: @escaping (Int) -> Void) -> MainModel.Response.MainSection {
        let characterItem = characters?.results.map { character in
            MainModel.Response.Item.character(
                iconName: character.image,
                name: character.name,
                id: character.id,
                action: action
            )
        }
        
        return .init(section: .title(title: MainTitleScetion.characters.rawValue), items: characterItem ?? [])
    }
}

//
//  CharacterDetailModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation


enum CharacterDetailModel {
    struct Response {
        var data: [CharacterDetailSection]
        
        struct CharacterDetailSection {
            var section: Sections
            var items: [Item]
        }
        
        enum Item {
            case avatar(icon: String)
            case description(
                title: String,
                name: String,
                url: String,
                action: ((String) -> Void)?
            )
            case episode(
                name: String,
                airDate: String,
                episode: String,
                url: String,
                action: ((String) -> Void)
            )
        }
    }
}

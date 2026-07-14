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
            var item: [Item]
        }
        
        enum Item {
            
        }
    }
}

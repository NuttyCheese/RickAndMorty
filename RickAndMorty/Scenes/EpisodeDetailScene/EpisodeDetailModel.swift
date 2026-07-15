//
//  EpisodeDetailModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

enum EpisodeDetailModel {
    struct Response {
        var data: [EpisodeDetailSection]
        
        struct EpisodeDetailSection {
            var section: Sections
            var items: [Item]
        }
        
        enum Item {
            
        }
    }
}

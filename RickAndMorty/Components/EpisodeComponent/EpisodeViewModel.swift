//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

final class EpisodeViewModel: ICellViewModel {
    let name: String
    let episode: String
    let airDate: String
    let url: String
    let action: ((String) -> Void)
    
    init(
        name: String,
        episode: String,
        airDate: String,
        url: String,
        action: @escaping (String) -> Void
    ) {
        self.name = name
        self.episode = episode
        self.airDate = airDate
        self.url = url
        self.action = action
    }
    
    func cellReuseID() -> String {
        EpisodeTableCell.description()
    }
}

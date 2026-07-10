//
//  EpisodeDTO.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 10.07.2026.
//

import Foundation

struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}

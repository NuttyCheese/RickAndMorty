//
//  InfoDTO.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 10.07.2026.
//

import Foundation

struct InfoDTO: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

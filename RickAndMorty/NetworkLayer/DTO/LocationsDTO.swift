//
//  LocationsDTO.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 10.07.2026.
//

import Foundation

struct LocationsDTO: Codable {
    let info: InfoDTO
    let results: [LocationDTO]
}

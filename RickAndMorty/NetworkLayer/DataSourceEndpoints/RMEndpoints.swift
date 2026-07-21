//
//  RMEndpoints.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

enum RMEndpoints {
    case character(id: Int)
    case charactersPage(page: Int?)
    
    case location(id: Int)
    case locationsPage(page: Int?)
    
    case episode(id: Int)
    case episodesPage(page: Int?)
}

extension RMEndpoints: INetworkRequest {
    var path: String {
        switch self {
        case let .character(id): "/api/character/\(id)"
        case .charactersPage(_): "/api/character"
        case let .location(id): "/api/location/\(id)"
        case .locationsPage(_): "/api/location"
        case let .episode(id): "/api/episode/\(id)"
        case .episodesPage(_): "/api/episode"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .charactersPage(page):
            var dict: [String: Int] = [:]
            
            if page != nil {
                dict["page"] = page
            }
            
            return .url(dict)
        case let .locationsPage(page):
            var dict: [String: Int] = [:]
            
            if page != nil {
                dict["page"] = page
            }
            
            return .url(dict)
        case let .episodesPage(page):
            var dict: [String: Int] = [:]
            
            if page != nil {
                dict["page"] = page
            }
            
            return .url(dict)
        default: return .none
        }
    }
}

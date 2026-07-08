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
    case characterAvatar(id: Int)
    
    case location
    case episode
}

extension RMEndpoints: INetworkRequest {
    var path: String {
        switch self {
        case let .character(id): "/api/character/\(id)"
        case .charactersPage(_): "/api/character"
        case let .characterAvatar(id): "/api/character/avatar/\(id)"
        case .location: "/api/location"
        case .episode: "/api/episode"
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
        default: return .none
        }
    }
}

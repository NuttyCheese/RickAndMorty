//
//  Parameters.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

public enum Parameters {
    case none
    case url([String: Any])
    case json([String: Any])
    case jsonArray([[String: Any]])
    case formData([String: Any])
    case data(Data, ContentType)
    case both(body: [String: Any], url: [String: Any])
    
    public var contentType: ContentType? {
        switch self {
        case .none: nil
        case .url: .json
        case .json: .json
        case .jsonArray: .json
        case .formData: .urlencoded
        case let .data(_, type): type
        case .both(body: _, url: _): .json
        }
    }
}

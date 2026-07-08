//
//  HTTPHeader.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

typealias HTTPHeader = [String: String]

enum HeaderField {
    case authorization(String)
    case contentType(ContentType)
    case accept(ContentType)
    case mobilePlatform(String)
    case mobileVersion(String)
    case mobileID(String)
    case acceptVersion(String)
    case userAgent(String)
    
    var key: String {
        switch self {
        case .authorization: "Authorization"
        case .contentType: "Content-Type"
        case .accept: "Accept"
        case .mobilePlatform: "Mobile-Platform"
        case .mobileVersion: "Mobile-Version"
        case .mobileID: "Mobile-Device-IDFA"
        case .acceptVersion: "X-Accept-Version"
        case .userAgent: "User-Agent"
        }
    }

    var value: String {
        switch self {
        case let .authorization(token): "Bearer \(token)"
        case let .contentType(contentType): contentType.value
        case let .accept(contentType): contentType.value
        case let .mobilePlatform(platform): platform
        case let .mobileVersion(version): version
        case let .mobileID(id): id
        case let .acceptVersion(version): version
        case let .userAgent(agent): agent
        }
    }
}

//
//  ContentType.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

public enum ContentType {
    case json
    case urlencoded
    case multipart(boundary: String)
    case jpeg
    case png
    
    public var value: String {
        switch self {
        case .json: "application/json"
        case .urlencoded: "application/x-www-form-urlencoded"
        case let .multipart(boundary): "multipart/form-data; boundary=\(boundary)"
        case .jpeg: "image/jpeg"
        case .png: "image/png"
        }
    }
}

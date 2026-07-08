//
//  CustomBaseURL.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

public enum CustomBaseURL {
    case main
    
    public var url: URL {
        switch self {
        case .main:
            URL(string: "https://rickandmortyapi.com")!
        }
    }
}

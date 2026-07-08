//
//  Enumeration.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

enum Sections {
    case title(title: String)
    
    var text: String {
        switch self {
        case let .title(title):
            title
        }
    }
}

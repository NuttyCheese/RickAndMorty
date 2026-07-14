//
//  MainModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

enum MainModel {
    struct Response {
        var data: [MainSection]
        
        struct MainSection {
            var section: Sections
            var items: [Item]
        }
        
        enum Item {
            case character(
                iconName: String,
                name: String,
                id: Int,
                action: ((Int) -> Void)
            )
        }
    }
}

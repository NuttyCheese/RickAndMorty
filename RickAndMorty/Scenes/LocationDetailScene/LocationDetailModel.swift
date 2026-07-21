//
//  LocationDetailModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

enum LocationDetailModel {
    struct Response {
        var data: [LocationDetailSection]
        
        struct LocationDetailSection {
            var section: Sections
            var items: [Item]
        }
        
        enum Item {
            
        }
    }
}

//
//  AvatarViewModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

final class AvatarViewModel: ICellViewModel {
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func cellReuseID() -> String {
        AvatarTableCell.description()
    }
}

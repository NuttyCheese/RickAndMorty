//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

final class CharacterViewModel: ICellViewModel {
    let iconName: String
    let name: String
    let id: Int
    let action: (Int) -> Void
    
    init(iconName: String, name: String, id: Int, action: @escaping (Int) -> Void) {
        self.iconName = iconName
        self.name = name
        self.id = id
        self.action = action
    }
    
    func cellReuseID() -> String {
        CharacterCollectionCell.description()
    }
}

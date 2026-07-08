//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

final class CharacterViewModel: ICellViewModel {
    
    
    func cellReuseID() -> String {
        CharacterCollectionCell.description()
    }
}

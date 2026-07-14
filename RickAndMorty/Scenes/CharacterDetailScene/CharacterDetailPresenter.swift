//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailPresenter {
    func update()
}

final class CharacterDetailPresenter {
    weak var viewController: ICharacterDetailView?
}

extension CharacterDetailPresenter: ICharacterDetailPresenter {
    func update() {
        
    }
}

private extension CharacterDetailPresenter {
    
}

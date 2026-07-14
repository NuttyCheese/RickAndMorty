//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailInteractor {
    func loadData()
}

final class CharacterDetailInteractor {
    private let presenter: ICharacterDetailPresenter
    private let router: ICharacterDetailRouter
    private let worker: ICharacterDetailWorker
    private let sectionManager: ICharacterDetailSectionManager
    private let identifier: Int
    
    private var sections = [CharacterDetailModel.Response.CharacterDetailSection]()
    
    init(
        presenter: ICharacterDetailPresenter,
        router: ICharacterDetailRouter,
        worker: ICharacterDetailWorker,
        sectionManager: ICharacterDetailSectionManager,
        identifier: Int
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.sectionManager = sectionManager
        self.identifier = identifier
    }
}

extension CharacterDetailInteractor: ICharacterDetailInteractor {
    func loadData() {
        worker.fetchLoadData(identifier: identifier) { character in
            print("name - \(character?.name ?? "")")
        }
    }
}

private extension CharacterDetailInteractor {
    
}

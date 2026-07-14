//
//  CharacterDetailWorker.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping(CharacterDTO?) -> ())
}

final class CharacterDetailWorker {
    private let dataSource = RMDataSourceRemote()
}

extension CharacterDetailWorker: ICharacterDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping (CharacterDTO?) -> ()) {
        loadData(id: identifier, completion: completion)
    }
}

private extension CharacterDetailWorker {
    func loadData(id: Int, completion: @escaping(CharacterDTO?) -> ()) {
        dataSource.getCharacter(id: id) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
}

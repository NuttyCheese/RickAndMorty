//
//  MainWorker.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol IMainWorker {
    func loadCharacters(page: Int?, completion: @escaping(CharactersDTO?) -> ())
}

final class MainWorker {
    private let rmDataSource = RMDataSourceRemote()
}

extension MainWorker: IMainWorker {
    func loadCharacters(page: Int?, completion: @escaping (CharactersDTO?) -> ()) {
        fetchCharactersData(page: page, completion: completion)
    }
}

private extension MainWorker {
    func fetchCharactersData(page: Int?, completion: @escaping(CharactersDTO?) -> ()) {
        rmDataSource.getCharactersPage(page: page) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
}

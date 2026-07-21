//
//  EpisodeDetailWorker.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol IEpisodeDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping(EpisodeDTO?) -> ())
}

final class EpisodeDetailWorker {
    private let dataSource = RMDataSourceRemote()
}

extension EpisodeDetailWorker: IEpisodeDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping (EpisodeDTO?) -> ()) {
        fetchData(identifier: identifier, completion: completion)
    }
}

private extension EpisodeDetailWorker {
    func fetchData(identifier: Int, completion: @escaping(EpisodeDTO?) -> ()) {
        dataSource.getEpisode(id: identifier) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
}

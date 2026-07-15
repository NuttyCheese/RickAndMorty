//
//  CharacterDetailWorker.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping(CharacterDTO?) -> ())
    func fetchLoadEpisode(identifier: Int, completion: @escaping([EpisodeDTO]?) -> ())
}

final class CharacterDetailWorker {
    private let dataSource = RMDataSourceRemote()
}

extension CharacterDetailWorker: ICharacterDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping (CharacterDTO?) -> ()) {
        loadData(id: identifier, completion: completion)
    }
    
    func fetchLoadEpisode(identifier: Int, completion: @escaping ([EpisodeDTO]?) -> ()) {
        loadEpisodes(id: identifier, completion: completion)
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
    
    func loadEpisodes(id: Int, completion: @escaping([EpisodeDTO]?) -> ()) {
        dataSource.getCharacter(id: id) { result in
            switch result {
            case .success(let character):
                let episodeIDs = character.episode.compactMap { urlString -> Int? in
                    guard let url = URL(string: urlString) else { return nil }
                    return Int(url.lastPathComponent)
                }
                
                // Проверяем, есть ли эпизоды
                guard !episodeIDs.isEmpty else {
                    completion([])
                    return
                }
                
                // Создаем группу для синхронизации
                let group = DispatchGroup()
                var episodes: [EpisodeDTO] = []
                let queue = DispatchQueue(label: "com.rickandmorty.episodes")
                
                for episodeID in episodeIDs {
                    group.enter()
                    self.dataSource.getEpisode(id: episodeID) { result in
                        defer { group.leave() }
                        
                        switch result {
                        case .success(let episode):
                            queue.async {
                                episodes.append(episode)
                            }
                        case .failure(let error):
                            print("❌ Ошибка загрузки эпизода \(episodeID): \(error)")
                        }
                    }
                }
                
                // Когда все запросы завершены
                group.notify(queue: .main) {
                    // Сортируем по ID и возвращаем
                    let sortedEpisodes = episodes.sorted { $0.id < $1.id }
                    completion(sortedEpisodes)
                }
                
            case .failure(let error):
                print("❌ Ошибка загрузки персонажа: \(error)")
                completion(nil)
            }
        }
    }
}

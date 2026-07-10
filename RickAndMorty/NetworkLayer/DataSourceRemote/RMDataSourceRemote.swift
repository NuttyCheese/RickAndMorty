//
//  RMDataSourceRemote.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 10.07.2026.
//

import Foundation

final class RMDataSourceRemote {
    private let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getCharactersPage(page: Int?, completion: @escaping(Result<CharactersDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .charactersPage(page: page), completion: completion)
    }
    
    func getCharacter(id: Int, completion: @escaping(Result<CharacterDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .character(id: id), completion: completion)
    }
    
    func getEpisode(id: Int, completion: @escaping(Result<EpisodeDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .episode(id: id), completion: completion)
    }
    
    func getEpisodesPage(page: Int?, completion: @escaping(Result<EpisodesDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .episodesPage(page: page), completion: completion)
    }
    
    func getLocation(id: Int, completion: @escaping(Result<LocationDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .location(id: id), completion: completion)
    }
    
    func getLocationsPage(page: Int?, completion: @escaping(Result<LocationsDTO, HTTPError>) -> ()) {
        networkSerivce(endpoint: .locationsPage(page: page), completion: completion)
    }
}

private extension RMDataSourceRemote {
    func networkSerivce<T: Codable>(endpoint: RMEndpoints, completion: @escaping(Result<T, HTTPError>) -> ()) {
        apiManager.request(endpoint: endpoint, completion: completion)
    }
}

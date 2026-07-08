//
//  NetworkDataService.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

protocol INetworkDataService {
    func request<T: Codable>(request: INetworkRequest, completion: @escaping(Result<T, HTTPError>) -> ())
    func requestData(request: INetworkRequest, completion: @escaping(Result<Data?, HTTPError>) -> ())
}

final class NetworkDataService: INetworkDataService {
    private let networkService: INetworkService
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func request<T>(request: any INetworkRequest, completion: @escaping (Result<T, HTTPError>) -> ()) where T : Decodable, T : Encodable {
        networkService.perform(request, completion: completion)
    }
    
    func requestData(request: any INetworkRequest, completion: @escaping (Result<Data?, HTTPError>) -> ()) {
        networkService.fetchData(request, completion: completion)
    }
}

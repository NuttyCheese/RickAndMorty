//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

final class APIManager {
    func request<T: Codable>(endpoint: INetworkRequest, completion: @escaping(Result<T, HTTPError>) -> ()) {
        performRequest(endpoint: endpoint, completion: completion)
    }
    
    func requestRawData(endpoint: INetworkRequest, completion: @escaping(Result<Data?, HTTPError>) -> ()) {
        performRequest(endpoint: endpoint, completion: completion)
    }
}

private extension APIManager {
    func performRequest<T: Codable>(endpoint: INetworkRequest, completion: @escaping(Result<T, HTTPError>) -> ()) {
        let networkService = NetworkService(session: URLSession.shared, requestBuilder: URLRequestBuilder())
        let networkDataService = NetworkDataService(networkService: networkService)
        
        if T.self == Data?.self {
            networkDataService.requestData(request: endpoint) { result in
                completion(result as! Result<T, HTTPError>)
            }
        }else {
            networkDataService.request(request: endpoint, completion: completion)
        }
    }
}

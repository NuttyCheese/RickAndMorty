//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import Foundation

protocol INetworkService {
    func perform<T: Codable>(_ request: INetworkRequest, completion: @escaping(Result<T, HTTPError>) -> ())
    func fetchData(_ request: INetworkRequest, completion: @escaping(Result<Data?, HTTPError>) -> ())
}

final class NetworkService: INetworkService {
    private let session: URLSession
    private let requestBuilder: IURLRequestBuilder
    private let queue = DispatchQueue.main
    
    init(session: URLSession, requestBuilder: IURLRequestBuilder) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    func perform<T>(_ request: INetworkRequest, completion: @escaping (Result<T, HTTPError>) -> ()) where T : Decodable, T : Encodable {
        let urlRequest = requestBuilder.build(forRequest: request)
        
        session.dataTask(with: urlRequest) { data, response, error in
            let networkResponse = NetworkResponse(data: data, urlResponse: response, request: urlRequest, error: error)
            
            switch networkResponse.result {
            case .success(let success):
                guard let data = success else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    self.queue.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    self.queue.async {
                        completion(.failure(.failedToDecodeResponse(error)))
                    }
                }
            case .failure(let failure):
                self.queue.async {
                    completion(.failure(failure))
                }
            }
        }.resume()
    }
    
    func fetchData(_ request: INetworkRequest, completion: @escaping (Result<Data?, HTTPError>) -> ()) {
        let urlRequest = requestBuilder.build(forRequest: request)
        perform(urlRequest: urlRequest, completion: completion)
    }
    
    private func perform(urlRequest: URLRequest, completion: @escaping(Result<Data?, HTTPError>) -> ()) {
        session.dataTask(with: urlRequest) { data, urlResponse, error in
            let networkResponse = NetworkResponse(data: data, urlResponse: urlResponse, error: error)
            completion(networkResponse.result)
        }.resume()
    }
}

//
//  NetworkResponse.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

struct NetworkResponse {
    let result: Result<Data?, HTTPError>
    
    init(
        data: Data? = nil,
        urlResponse: URLResponse? = nil,
        request _: URLRequest? = nil,
        error: Error? = nil
    ) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            result = .failure(.invalidResponse(urlResponse))
            return
        }
        
        let statusCode = urlResponse.statusCode
        guard let status = ResponseStatus(rawValue: statusCode) else {
            result = .failure(.invalidStatusCode(statusCode, data))
            return
        }
        
        if status.isSuccess {
            if let error {
                result = .failure(.networkError(error))
            }else {
                result = .success(data)
            }
            return
        }
        
        if let data, !data.isEmpty {
            do {
                let decoder = JSONDecoder()
                var errorDTO = try decoder.decode(ErrorDTO.self, from: data)
                errorDTO.statusCode = statusCode
                result = .failure(.apiError(errorDTO))
                return
            }catch {
                print("🔴 Failed to decode error response in NetworkResponse: \(error)")
            }
        } else {
            print("🟡 No data or empty data for error parsing")
        }
        
        result = .failure(.invalidStatusCode(statusCode, data))
    }
}

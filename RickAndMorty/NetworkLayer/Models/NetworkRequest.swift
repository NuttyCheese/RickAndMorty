//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol INetworkRequest {
    var baseURL: CustomBaseURL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeader? { get }
    var parameters: Parameters { get }
}

extension INetworkRequest {
    var baseURL: CustomBaseURL { .main }
    
    var header: HTTPHeader? {
        var headers = HTTPHeader()
        
        let defaultHeaders: [HeaderField] = [
            .accept(.json)
        ]
        
        for headerField in defaultHeaders {
            headers[headerField.key] = headerField.value
        }
        
        return headers
    }
}

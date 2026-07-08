//
//  URLRequestBuilder.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol IURLRequestBuilder {
    func build(forRequest request: INetworkRequest) -> URLRequest
}

struct URLRequestBuilder: IURLRequestBuilder {
    func build(forRequest request: INetworkRequest) -> URLRequest {
        let url = request.baseURL.url.appendingPathComponent(request.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        
        let params = request.parameters
        urlRequest.add(parameters: params)
        
        let contentType = params.contentType ?? .json
        urlRequest.add(header: .contentType(contentType))
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        urlRequest.setValue("", forHTTPHeaderField: "Cookie")
        
        urlRequest.add(header: .authorization(""))
        
        return urlRequest
    }
}

extension URLComponents {
    /// Устанавливает параметры в виде словаря и возвращается новая структура
    /// - Parameter parameters: Параметры для URLComponents
    /// - Returns: новая структура с установленными параметрами
    func setParameters(_ parameters: [String: Any]) -> URLComponents {
        var urlComponents = self
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        return urlComponents
    }
}

extension URL {
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [:]) { result, item in
            result[item.name] = item.value
        }
    }
}

extension URLRequest {
    mutating func add(header: HeaderField) {
        setValue(header.value, forHTTPHeaderField: header.key)
    }

    /// Метод добавляющий параметры
    /// - Parameter parameters: параметры типа RequestParameters
    public mutating func add(parameters: Parameters) {
        switch parameters {
        case .none:
            break

        case let .url(dictionary):
            guard let url,
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { break }
            components = components.setParameters(dictionary)
            guard let newURL = components.url else { break }
            self.url = newURL

        case let .json(dictionary):
            httpBody = try? JSONSerialization.data(withJSONObject: dictionary)

        case let .jsonArray(dictionary):
            httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)

        case let .formData(dictionary):
            httpBody = URLComponents().setParameters(dictionary).query?.data(using: .utf8)

        case let .data(data, _):
            httpBody = data

        case let .both(body, urlParams):
            // Добавляем URL-параметры
            if let currentURL = url,
               var components = URLComponents(url: currentURL, resolvingAgainstBaseURL: false)
            {
                components = components.setParameters(urlParams)
                if let newURL = components.url {
                    url = newURL
                }
            }
            // Добавляем JSON body
            httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
    }
}

